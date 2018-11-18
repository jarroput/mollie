defmodule Molliex.Methods do
  import Molliex
  alias Molliex.Client

  @doc """
  List all available payment methods.

  ## Example

      Molliex.Methods.list client
      
  More info at: https://docs.mollie.com/reference/v2/methods-api/list-methods
  """
  @spec list(Client.t(), map) :: Molliex.response()
  def list(client, params \\ %{}) do
    get("v2/methods", client, params)
  end

  @doc """
  Retrieve a single method by its ID. 
  Note that if a method is not available on the website profile a status 404 Not found is returned. 
  When the method is not enabled, a status 403 Forbidden is returned.

  ## Example

      Molliex.Methods.find client, "ideal"

  More info at: https://docs.mollie.com/reference/v2/methods-api/get-method
  """
  @spec find(Client.t(), binary, map) :: Molliex.response()
  def find(client, id, params \\ %{}) do
    get("v2/methods/#{id}", client, params)
  end
end
