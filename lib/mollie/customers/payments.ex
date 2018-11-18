defmodule Mollie.Customers.Payments do
  import Mollie
  alias Mollie.Client

  @doc """
  Retrieve all payments linked to the customer.

  ## Example

      Mollie.Customers.Payments.list client, "cst_8wmqcHMN4U"

  More info at: https://docs.mollie.com/reference/v2/customers-api/list-customer-payments
  """
  @spec list(Client.t(), binary) :: Mollie.response()
  def list(client, customer_id) do
    get("v2/customers/#{customer_id}/payments", client)
  end

  @doc """
  Creates a payment for the customer.
  This endpoint is a shortcut for creating a payment with a `customerId` parameter.

  For an example request body see `Mollie.Payments.create\2`.

  ## Example

      Mollie.Customers.Payments client, "cst_8wmqcHMN4U", payment_body

  More info at: https://docs.mollie.com/reference/v2/customers-api/create-customer-payment
  """
  @spec create(Client.t(), binary, map) :: Mollie.response()
  def create(client, customer_id, body) do
    post("v2/customers/#{customer_id}/payments", client, body)
  end
end
