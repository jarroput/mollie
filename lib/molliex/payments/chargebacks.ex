defmodule Molliex.Payments.Chargebacks do
  import Molliex
  alias Molliex.Client

  @doc """
  Retrieve a single chargeback for a payment by its ID.

  ## Example

      Molliex.Payments.Chargebacks.find client, "tr_7UhSN1zuXS", "chb_n9z0tp"

  More info at: https://docs.mollie.com/reference/v2/chargebacks-api/get-chargeback
  """
  @spec find(Client.t(), binary, binary) :: Molliex.response()
  def find(client, payment_id, id) do
    get("v2/payments/#{payment_id}/chargebacks/#{id}", client)
  end
end
