defmodule Mollie.Organizations do
  import Mollie
  alias Mollie.Client

  @doc """
  Retrieve the currently authenticated organization.

  ## Example

      Mollie.Organizations.me client

  More info at: https://docs.mollie.com/reference/v2/organizations-api/current-organization
  """
  @spec me(Client.t()) :: Mollie.response()
  def me(client) do
    get("v2/organizations/me", client)
  end

  @doc """
  Retrieve all organizations that are connected to your partner-account.
  This API is only for partners.

  ## Example

      Mollie.Organizations.list client

  More info at: https://docs.mollie.com/reference/v2/organizations-api/list-organizations
  """
  @spec list(Client.t(), map | list) :: Mollie.response()
  def list(client, params \\ %{}) do
    get("v2/organizations", client, params)
  end

  @doc """
  Retrieve an organization by its ID.

  ## Example

      Mollie.Organizations.find client, "org_12345678"

  More info at: https://docs.mollie.com/reference/v2/organizations-api/get-organization
  """
  @spec find(Client.t(), binary) :: Mollie.response()
  def find(client, id) do
    get("v2/organizations/#{id}", client)
  end
end
