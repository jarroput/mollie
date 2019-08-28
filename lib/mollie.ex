defmodule Mollie do
  use HTTPoison.Base
  alias Mollie.Client

  @user_agent [{"User-agent", "mollie_ex"}]

  @type response ::
          {:ok, iodata(), HTTPoison.Response.t()}
          | {integer, any, HTTPoison.Response.t()}
  @type pagination_response :: {response, binary | nil, Client.auth()}

  @moduledoc """
  Documentation for Mollie.
  """

  def process_response_body(""), do: nil
  def process_response_body(body), do: Jason.decode!(body)

  def process_response(%HTTPoison.Response{status_code: status_code, body: body} = resp),
    do: {status_code, body, resp}

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
    raw_request(method, url, Jason.encode!(body), headers, options)
  end

  def raw_request(method, url, body \\ "", headers \\ [], options \\ []) do
    method
    |> request!(url, body, headers, options)
    |> process_response
  end

  @spec url(client :: Client.t(), path :: binary) :: binary
  defp url(%Client{endpoint: endpoint}, path) do
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
  defp merge_uri_params(uri, %{}), do: uri
  defp merge_uri_params(uri, []), do: uri

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

  defp encode_query(params) when is_map(params) do
    params
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

  def authorization_header(%{api_key: key}, headers) do
    headers ++ [{"Authorization", "Bearer #{key}"}]
  end

  def authorization_header(_, headers), do: headers
end
