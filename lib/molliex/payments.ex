defmodule Molliex.Payments do
  import Molliex
  alias Molliex.Client

  @doc """
  Retrieve all payments created with the current website profile, ordered from newest to oldest.
  Results are paginated.

  ## Examples

      Molliex.Payments.list client
      Molliex.Payments.list client, %{limit: 100, from: "tr_7UhSN1zuXS"}

  More info at: https://docs.mollie.com/reference/v2/payments-api/list-payments
  """
  @spec list(Client.t(), map) :: Molliex.response()
  def list(client, params \\ %{}) do
    get("v2/payments", client, params)
  end

  @doc """
  Retrieve a single payment object by its payment token.

  ## Example

      Molliex.Payments.find client, "tr_7UhSN1zuXS"

  More info at https://docs.mollie.com/reference/v2/payments-api/get-payment
  """
  @spec find(Client.t(), binary, map) :: Molliex.response()
  def find(client, id, params \\ %{}) do
    get("v2/payments/#{id}", client, params)
  end

  @doc """
  Creates a single payment.

  Payment body example
  ```
  %{
    "amount" => %{
      "currency" => "USD",
      "value" => "100.00"
    },
    "description" => "Blue suede shows",
    "redirectUrl" => "https://shop.example.com/checkout"
  }
  ```

  ## Example

      Molliex.Payments.create client, payment_body

  More info at: https://docs.mollie.com/reference/v2/payments-api/create-payment
  """
  @spec create(Client.t(), map | list) :: Molliex.response()
  def create(client, body) do
    post("v2/payments", client, body)
  end

  @doc """
  Cancels a payment.

  ## Example

      Molliex.Payments.cancel client, "tr_7UhSN1zuXS"

  More info at: https://docs.mollie.com/reference/v2/payments-api/cancel-payment
  """
  @spec cancel(Client.t(), binary, map) :: Molliex.response()
  def cancel(client, id, params \\ %{}) do
    delete("v2/payments/#{id}", client, params)
  end
end
