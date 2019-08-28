defmodule Mollie.Client do
  defstruct auth: nil, endpoint: "https://api.mollie.com/", options: []

  @type auth :: %{api_key: binary}
  @type t :: %__MODULE__{auth: auth | nil, endpoint: binary, options: list}

  @spec new() :: t
  def new, do: %__MODULE__{}

  @spec new(binary) :: t
  def new(endpoint) when is_binary(endpoint) do
    pnew(nil, endpoint)
  end

  @spec new(map()) :: t
  def new(auth = %{api_key: _}), do: %__MODULE__{auth: auth}

  @spec new(auth, binary | list) :: t
  def new(auth = %{api_key: _}, endpoint) when is_binary(endpoint) do
    pnew(auth, endpoint)
  end

  def new(auth = %{api_key: _}, options) when is_list(options) do
    %__MODULE__{auth: auth, options: options}
  end

  defp pnew(auth, endpoint, options \\ []) do
    endpoint =
      if String.ends_with?(endpoint, "/") do
        endpoint
      else
        endpoint <> "/"
      end

    %__MODULE__{auth: auth, endpoint: endpoint, options: options}
  end
end
