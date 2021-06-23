defmodule Mollie.Payments do
  import Mollie
  alias Mollie.Client

  @moduledoc """
  Payment creation is elemental to the Mollie API: this is where most payment implementations start off.

  Once you have created a payment, you should redirect your customer to the URL in the `_links.checkout` property from the response.
  """

  @doc """
  Retrieve all payments created with the current website profile, ordered from newest to oldest.
  Results are paginated.

  ## Examples

      Mollie.Payments.list client
      Mollie.Payments.list client, %{limit: 100, from: "tr_7UhSN1zuXS"}

  More info at: https://docs.mollie.com/reference/v2/payments-api/list-payments
  """
  @spec list(Client.t(), map) :: Mollie.response()
  def list(client, params \\ %{}) do
    get("v2/payments", client, params)
  end

  @doc """
  Retrieve a single payment object by its payment token.

  ## Example

      Mollie.Payments.find client, "tr_7UhSN1zuXS"

  More info at https://docs.mollie.com/reference/v2/payments-api/get-payment
  """
  @spec find(Client.t(), binary, map) :: Mollie.response()
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

      Mollie.Payments.create client, payment_body

  More info at: https://docs.mollie.com/reference/v2/payments-api/create-payment
  """
  @spec create(Client.t(), map() | list) :: Mollie.response()
  def create(client, body) do
    post("v2/payments", client, body)
  end

  @doc """
  Cancels a payment.

  ## Example

      Mollie.Payments.cancel client, "tr_7UhSN1zuXS"

  More info at: https://docs.mollie.com/reference/v2/payments-api/cancel-payment
  """
  @spec cancel(Client.t(), binary, map) :: Mollie.response()
  def cancel(client, id, params \\ %{}) do
    delete("v2/payments/#{id}", client, params)
  end
end
