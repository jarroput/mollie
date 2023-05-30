defmodule Mollie do
  alias Finch.Response
  alias Mollie.Client
  require Logger

  @user_agent [{"User-agent", "MollieElixir/#{Application.spec(:mollie, :vsn)}"}]

  @type response ::
          {:ok, iodata(), Response.t()}
          | {integer, any, Response.t()}
  @type pagination_response :: {response, binary | nil, Client.auth()}
  @idempotency_key_header "Idempotency-Key"
  @retry_responses [500, 502, 503, 504]

  @moduledoc """
  Documentation for Mollie.
  """

  def child_spec(opts \\ nil) do
    Finch.child_spec(name: __MODULE__, pools: default_pools(opts))
  end

  def default_pools(opts) when is_map(opts), do: opts

  def default_pools(_) do
    %{
      :default => [size: 10]
    }
  end

  def process_response_body(""), do: nil
  def process_response_body(body), do: Jason.decode!(body)

  def handle_response({:ok, %Response{body: body, status: status} = response}) do
    body = process_response_body(body)
    {status, body, response}
  end

  def handle_response({:error, %Mint.TransportError{} = error}) do
    {500, %{"status" => 500, "error" => "transport_error"}, error}
  end

  def handle_response({:error, %Mint.HTTPError{} = error}) do
    {500, %{"status" => 500, "error" => "http_error"}, error}
  end

  @spec delete(binary, Client.t(), any) :: response
  def delete(path, client, body \\ "") do
    _request(:delete, url(client, path), client.auth, body, client.options)
  end

  @spec post(binary, Client.t(), any) :: response
  def post(path, client, body \\ "") do
    _request(:post, url(client, path), client.auth, body, client.options)
  end

  @spec patch(binary, Client.t(), any) :: response
  def patch(path, client, body \\ "") do
    _request(:patch, url(client, path), client.auth, body, client.options)
  end

  @spec put(binary, Client.t(), any) :: response
  def put(path, client, body \\ "") do
    _request(:put, url(client, path), client.auth, body, client.options)
  end

  @spec get(binary, Client.t()) :: response
  @spec get(binary, Client.t(), map()) :: response
  @spec get(binary, Client.t(), map(), list) ::
          response | Enumerable.t() | pagination_response
  def get(path, client, params \\ %{}, options \\ []) do
    url =
      client
      |> url(path)
      |> add_params_to_url(params)

    raw_request(:get, url, "", authorization_header(client.auth, @user_agent), options)
  end

  def _request(method, url, auth, body \\ "", options \\ []) do
    json_request(method, url, body, authorization_header(auth, @user_agent), options)
  end

  def json_request(method, url, body \\ "", headers \\ [], options \\ []) do
    headers = headers ++ [{"Content-Type", "application/json"}]
    raw_request(method, url, encode_body(body), headers, options)
  end

  defp encode_body(""), do: ""
  defp encode_body(nil), do: ""
  defp encode_body(body), do: Jason.encode!(body)

  def raw_request(method, url, body \\ "", headers \\ [], options \\ []) do
    headers = maybe_add_idempotency_header(headers, method, options)

    request = Finch.build(method, url, headers, body)

    do_raw_request(request, options, {:attempts, 1})
  end

  defp do_raw_request(request, options, {:attempts, attempts}) do
    response =
      request
      |> Finch.request(__MODULE__, options)

    do_raw_request(request, options, add_attempts(request.headers, response, options, attempts))
  end

  defp do_raw_request(_request, _options, {:response, response}) do
    handle_response(response)
  end

  defp add_attempts(headers, response, options, attempts) do
    has_idempotency? = List.keyfind(headers, @idempotency_key_header, 0) != nil

    if has_idempotency? and should_retry?(response) and attempts < options[:max_attempts] do
      attempts
      |> backoff(options)
      |> :timer.sleep()

      {:attempts, attempts + 1}
    else
      {:response, response}
    end
  end

  @spec url(client :: Client.t(), path :: binary) :: binary
  def url(%Client{endpoint: endpoint}, path) do
    endpoint <> path
  end

  @spec add_params_to_url(binary, map) :: binary
  def add_params_to_url(url, params) do
    url
    |> URI.parse()
    |> merge_uri_params(params)
    |> String.Chars.to_string()
  end

  @spec merge_uri_params(URI.t(), map() | list) :: URI.t()
  defp merge_uri_params(%URI{query: nil} = uri, params) when is_list(params) or is_map(params) do
    uri
    |> Map.put(:query, encode_query(params))
  end

  defp merge_uri_params(%URI{} = uri, params) when is_list(params) or is_map(params) do
    uri
    |> Map.update!(:query, fn q ->
      q
      |> URI.decode_query()
      |> Map.merge(param_list_to_map_with_string_keys(params))
      |> encode_query()
    end)
  end

  defp merge_uri_params(uri, _), do: uri

  defp encode_query(params) when is_map(params) do
    params
    |> Enum.sort()
    |> Enum.map_join("&", &encode_query(&1))
  end

  defp encode_query(kv) do
    encode_kv_pair(kv)
  end

  defp encode_kv_pair({key, _}) when is_list(key) do
    raise ArgumentError, "encode_query/1 keys cannot be lists, got: #{inspect(key)}"
  end

  defp encode_kv_pair({_, value}) when is_list(value) do
    raise ArgumentError, "encode_query/1 values cannot be lists, got: #{inspect(value)}"
  end

  defp encode_kv_pair({key, value}) when is_map(value) do
    Enum.map_join(value, "&", fn {k, v} ->
      encode(key) <> "[" <> encode(k) <> "]=" <> encode(v)
    end)
  end

  defp encode_kv_pair({key, value}) do
    encode(key) <> "=" <> encode(value)
  end

  defp encode(val), do: URI.encode_www_form(Kernel.to_string(val))

  @spec param_list_to_map_with_string_keys(list) :: map
  defp param_list_to_map_with_string_keys(list) when is_list(list) or is_map(list) do
    for {key, value} <- list, into: Map.new() do
      {"#{key}", value}
    end
  end

  def authorization_header(%{username: user, password: pass}, headers)
      when is_binary(user) and is_binary(pass) do
    headers ++ [{"Authorization", encode_basic_auth(user, pass)}]
  end

  def authorization_header(%{api_key: key}, headers) do
    headers ++ [{"Authorization", "Bearer #{key}"}]
  end

  def authorization_header(_, headers), do: headers

  defp encode_basic_auth(username, password) do
    user_pw_encoded = Base.encode64("#{username}:#{password}")
    "Basic #{user_pw_encoded}"
  end

  defp maybe_add_idempotency_header(headers, :post, options) do
    idempotency_key =
      options[:idempotency_key]
      |> then(fn
        nil -> generate_idempotency_key()
        func when is_function(func, 0) -> func.()
        _ -> raise "Idempotency option should be a zero-arity function"
      end)

    List.insert_at(
      headers,
      -1,
      {@idempotency_key_header, idempotency_key}
    )
  end

  defp maybe_add_idempotency_header(headers, _method, _options), do: headers

  defp generate_idempotency_key() do
    <<u0::48, _::4, u1::12, _::2, u2::62>> = :crypto.strong_rand_bytes(16)
    <<u0::48, 4::4, u1::12, 2::2, u2::62>> |> :binary.encode_hex()
  end

  defp should_retry?({:error, %Mint.TransportError{}}), do: true
  defp should_retry?({:error, %Mint.HTTPError{}}), do: true
  defp should_retry?({:ok, %{status: status}}) when status in @retry_responses, do: true
  defp should_retry?(_), do: false

  defp backoff(attempts, options) do
    base_backoff = options[:base_backoff]
    max_backoff = options[:max_backoff]

    (base_backoff * :math.pow(2, attempts))
    |> min(max_backoff)
    |> jitter()
    |> max(base_backoff)
    |> trunc()
  end

  defp jitter(value) do
    value * (0.5 * (1 + :rand.uniform()))
  end
end
