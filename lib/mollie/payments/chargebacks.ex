defmodule Mollie.Payments.Chargebacks do
  import Mollie
  alias Mollie.Client

  @doc """
  Retrieve a single chargeback for a payment by its ID.

  ## Example

      Mollie.Payments.Chargebacks.find client, "tr_7UhSN1zuXS", "chb_n9z0tp"

  More info at: https://docs.mollie.com/reference/v2/chargebacks-api/get-chargeback
  """
  @spec find(Client.t(), binary, binary) :: Mollie.response()
  def find(client, payment_id, id) do
    get("v2/payments/#{payment_id}/chargebacks/#{id}", client)
  end
end
