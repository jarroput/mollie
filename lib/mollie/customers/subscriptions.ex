defmodule Mollie.Customers.Subscriptions do
  import Mollie
  alias Mollie.Client

  @doc """
  Retrieve all subscriptions of a customer.
  Results are paginated.

  ## Example

      Mollie.Customers.Subscriptions.list client, "cst_8wmqcHMN4U"

  More info at: https://docs.mollie.com/reference/v2/subscriptions-api/list-subscriptions
  """
  @spec list(Client.t(), binary, map | list) :: Mollie.response()
  def list(client, customer_id, params \\ %{}) do
    get("v2/customers/#{customer_id}/subscriptions", client, params)
  end

  @doc """
  Retrieve all payments of a specific subscriptions of a customer.
  Results are paginated.

  ## Example

      Mollie.Customers.Subscriptions.list_payments client, "cst_8wmqcHMN4U", "sub_rVKGtNd6s3"

  More info at: https://docs.mollie.com/reference/v2/subscriptions-api/list-subscriptions-payments
  """
  @spec list_payments(Client.t(), binary, binary, map | list) :: Mollie.response()
  def list_payments(client, customer_id, id, params \\ %{}) do
    get("v2/customers/#{customer_id}/subscriptions/#{id}/payments", client, params)
  end

  @doc """
  Retrieve a subscription by its ID and its customer’s ID.

  ## Example

      Mollie.Customers.Subscriptions.find client, "cst_8wmqcHMN4U", "sub_rVKGtNd6s3"

  More info at: https://docs.mollie.com/reference/v2/subscriptions-api/get-subscription
  """
  @spec find(Client.t(), binary, binary, map | list) :: Mollie.response()
  def find(client, customer_id, id, params \\ %{}) do
    get("v2/customers/#{customer_id}/subscriptions/#{id}", client, params)
  end

  @doc """
  Create a subscription to schedule recurring payments to take place at regular intervals.

  Subscription body example
  ```
  %{
    "amount" => %{
      "value" => "19.95",
      "currency" => "EUR"
    },
    "interval" => "1 month",
    "description" => "Monthly subscription"
  }
  ```

  ## Example

      Mollie.Customers.Subscriptions client, "cst_8wmqcHMN4U", subscription_body

  More info at: https://docs.mollie.com/reference/v2/subscriptions-api/create-subscription
  """
  @spec create(Client.t(), binary, map) :: Mollie.response()
  def create(client, customer_id, body \\ %{}) do
    post("v2/customers/#{customer_id}/subscriptions", client, body)
  end

  @doc """
  Cancels a subscription.

  ## Example

      Mollie.Customers.Subscriptions client, "cst_stTC2WHAuS", "sub_rVKGtNd6s3"

  More info at: https://docs.mollie.com/reference/v2/subscriptions-api/cancel-subscription
  """
  @spec cancel(Client.t(), binary, binary, map | list) :: Mollie.response()
  def cancel(client, customer_id, id, params \\ %{}) do
    delete("v2/customers/#{customer_id}/subscriptions/#{id}", client, params)
  end
end
