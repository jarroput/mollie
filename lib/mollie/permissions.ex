defmodule Mollie.Permissions do
  import Mollie
  alias Mollie.Client

  @doc """
  List all permissions available with the current app access token. The list is not paginated.

  ## Example

      Mollie.Permissions.list client

  More info at: https://docs.mollie.com/reference/v2/permissions-api/list-permissions
  """
  @spec list(Client.t()) :: Mollie.response()
  def list(client) do
    get("v2/permissions", client)
  end

  @doc """
  Check if API action is still allowed with current authorization.

  ## Example

      Mollie.Permissions.find client, "payments.read"

  More info at: https://docs.mollie.com/reference/v2/permissions-api/get-permission
  """
  @spec find(Client.t(), binary) :: Mollie.response()
  def find(client, id) do
    get("v2/permissions/#{id}", client)
  end
end
