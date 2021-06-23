defmodule Mollie.Payments.Chargebacks do
  import Mollie
  alias Mollie.Client

  @moduledoc """
  List chargebacks for your orgnaization or retrieve a single chargeback by its ID. Note the original payment’s ID is needed as well.
  """

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

  @doc """
  Retrieve all received chargebacks. If the payment-specific endpoint is used, only chargebacks for that specific payment are returned.

  ## Example

      Mollie.Payments.Chargebacks.list client, %{limit: 10}

  More info at: https://docs.mollie.com/reference/v2/chargebacks-api/list-chargebacks
  """
  @spec list(Client.t(), map | list) :: Mollie.response()
  def list(client, params \\ %{}) do
    get("v2/chargebacks", client, params)
  end
end
