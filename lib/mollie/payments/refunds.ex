defmodule Mollie.Payments.Refunds do
  import Mollie
  alias Mollie.Client

  @doc """
  Retrieve a single refund by its ID.

  ## Example

      Mollie.Payments.Refunds.find client, "tr_7UhSN1zuXS", "re_4qqhO89gsT"

  More info at: https://docs.mollie.com/reference/v2/refunds-api/get-refund
  """
  @spec find(Client.t(), binary, binary, map) :: Mollie.response()
  def find(client, payment_id, id, params \\ %{}) do
    get("v2/payments/#{payment_id}/refunds/#{id}", client, params)
  end

  @doc """
  Creates a refund on an existing payment.

  Refund body example
  ```
  %{
    "amount" => %{
      "currency" => "EUR",
      "value" => "25.00"
    },
    "descripton" => "Discount"
  }
  ```

  ## Example

      Mollie.Payments.Refunds.create client, "tr_7UhSN1zuXS", refund_body

  More info at: https://docs.mollie.com/reference/v2/refunds-api/create-refund
  """
  @spec create(Client.t(), binary, map | list) :: Mollie.response()
  def create(client, payment_id, body) do
    post("v2/payments/#{payment_id}/refunds", client, body)
  end

  @doc """
  Cancels a refund for a payment.

  ## Example

      Mollie.Payments.Refunds.cancel client, "tr_7UhSN1zuXS", "re_4qqhO89gsT"

  More info at: https://docs.mollie.com/reference/v2/refunds-api/cancel-refund
  """
  @spec cancel(Client.t(), binary, binary, map) :: Mollie.response()
  def cancel(client, payment_id, id, params \\ %{}) do
    delete("v2/payments/#{payment_id}/refunds/#{id}", client, params)
  end
end
