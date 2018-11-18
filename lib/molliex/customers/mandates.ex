defmodule Molliex.Customers.Mandates do
  import Molliex
  alias Molliex.Client

  @doc """
  Retrieve all mandates for the given `customer_id`, ordered from newest to oldest.
  Results are paginated.

  ## Example

      Molliex.Customers.Mandates.list client, "cst_8wmqcHMN4U"

  More info at: https://docs.mollie.com/reference/v2/mandates-api/list-mandates
  """
  @spec list(Client.t(), binary, map | list) :: Molliex.response()
  def list(client, customer_id, params \\ %{}) do
    get("v2/customers/#{customer_id}/mandates", client, params)
  end

  @doc """
  Retrieve a mandate by its ID and its customer’s ID.
  The mandate will either contain IBAN or credit card details, depending on the type of mandate.

  ## Example

      Molliex.Customers.Mandates.find client, "cst_8wmqcHMN4U", "mdt_pWUnw6pkBN"

  More info at: https://docs.mollie.com/reference/v2/mandates-api/get-mandate
  """
  @spec find(Client.t(), binary, binary, map | list) :: Molliex.response()
  def find(client, customer_id, id, params \\ %{}) do
    get("v2/customers/#{customer_id}/mandates/#{id}", client, params)
  end

  @doc """
  Create a mandate for a specific customer.

  Mandate body example
  ```
  %{
    "method" => "directdebit",
    "consumerName" => "Piet Mondriaan",
    "consumerAccount" => "NL55INGB0000000000"
  }
  ```

  ## Example

      Molliex.Customers.Mandates.create client, "cst_8wmqcHMN4U", mandate_body

  More info at: https://docs.mollie.com/reference/v2/mandates-api/create-mandate
  """
  @spec create(Client.t(), binary, map) :: Molliex.response()
  def create(client, customer_id, body) do
    post("v2/customers/#{customer_id}/mandates", client, body)
  end

  @doc """
  Revoke a customer’s mandate.
  You will no longer be able to charge the consumer’s bank account or credit card with this mandate and all connected subscriptions will be canceled.

  ## Example

      Molliex.Customers.Mandates.revoke client, "cst_8wmqcHMN4U", "mdt_pWUnw6pkBN"

  More info at: https://docs.mollie.com/reference/v2/mandates-api/revoke-mandate
  """
  @spec revoke(Client.t(), binary, binary, map | list) :: Molliex.response()
  def revoke(client, customer_id, id, params \\ %{}) do
    delete("v2/customers/#{customer_id}/mandates/#{id}", client, params)
  end
end
