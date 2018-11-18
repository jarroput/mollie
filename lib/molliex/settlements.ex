defmodule Molliex.Settlements do
  import Molliex
  alias Molliex.Client

  @doc """
  Retrieve all settlements, ordered from new to old.
  Results are paginated.

  ## Example

      Molliex.Settlements.list client

  More info at: https://docs.mollie.com/reference/v2/settlements-api/list-settlements
  """
  @spec list(Client.t(), map | list) :: Molliex.response()
  def list(client, params) do
    get("v2/settlements", client, params)
  end

  @doc """
  Retrieve the details of the open balance of the organization.

  ## Example

      Molliex.Settlements.open client

  More info at: https://docs.mollie.com/reference/v2/settlements-api/get-open-settlement
  """
  @spec open(Client.t()) :: Molliex.response()
  def open(client) do
    get("v2/settlements/open", client)
  end

  @doc """
  Retrieve the details of the current settlement that has not yet been paid out.

  ## Example

      Molliex.Settlements.next client

  More info at: https://docs.mollie.com/reference/v2/settlements-api/get-next-settlement
  """
  @spec next(Client.t()) :: Molliex.response()
  def next(client) do
    get("v2/settlements/next", client)
  end

  @doc """
  Retrieve a single settlement.

  ## Example

      Molliex.Settlements.find client, "stl_jDk30akdN"

  More info at: https://docs.mollie.com/reference/v2/settlements-api/get-settlement
  """
  @spec find(Client.t(), binary) :: Molliex.response()
  def find(client, id) do
    get("v2/settlements/#{id}", client)
  end

  @doc """
  Retrieve all payments included in a settlement.

  ## Example

      Molliex.Settlements.list_payments client, "stl_jDk30akdN"

  More info at: https://docs.mollie.com/reference/v2/settlements-api/list-settlement-payments
  """

  @spec list_payments(Client.t(), binary) :: Molliex.response()
  def list_payments(client, id) do
    get("v2/settlements/#{id}/payments", client)
  end

  @doc """
  Retrieve all refunds included in a settlement.

  ## Example

      Molliex.Settlements.list_refunds client, "stl_jDk30akdN"

  More info at: https://docs.mollie.com/reference/v2/settlements-api/list-settlement-refunds
  """

  @spec list_refunds(Client.t(), binary) :: Molliex.response()
  def list_refunds(client, id) do
    get("v2/settlements/#{id}/refunds", client)
  end

  @doc """
  Retrieve all chargebacks included in a settlement.

  ## Example

      Molliex.Settlements.list_chargebacks client, "stl_jDk30akdN"

  More info at: https://docs.mollie.com/reference/v2/settlements-api/list-settlement-chargebacks
  """
  @spec list_chargebacks(Client.t(), binary) :: Molliex.response()
  def list_chargebacks(client, id) do
    get("v2/settlements/#{id}/chargebacks", client)
  end

  @doc """
  Retrieve all captures included in a settlement.

  ## Example

      Molliex.Settlements.list_captures client, "stl_jDk30akdN"

  More info at: https://docs.mollie.com/reference/v2/settlements-api/list-settlement-captures
  """
  @spec list_captures(Client.t(), binary) :: Molliex.response()
  def list_captures(client, id) do
    get("v2/settlements/#{id}/captures", client)
  end
end
