defmodule Molliex.Permissions do
  import Molliex
  alias Molliex.Client

  @doc """
  List all permissions available with the current app access token. The list is not paginated.

  ## Example

      Molliex.Permissions.list client

  More info at: https://docs.mollie.com/reference/v2/permissions-api/list-permissions
  """
  @spec list(Client.t()) :: Molliex.response()
  def list(client) do
    get("v2/permissions", client)
  end

  @doc """
  Check if API action is still allowed with current authorization.

  ## Example

      Molliex.Permissions.find client, "payments.read"

  More info at: https://docs.mollie.com/reference/v2/permissions-api/get-permission
  """
  @spec find(Client.t(), binary) :: Molliex.response()
  def find(client, id) do
    get("v2/permissions/#{id}", client)
  end
end
