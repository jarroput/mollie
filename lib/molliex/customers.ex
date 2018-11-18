defmodule Molliex.Customers do
  import Molliex
  alias Molliex.Client

  @doc """
  Retrieve all customers created. Results are paginated.

  ## Example

      Molliex.Customers.list client

  More info at: https://docs.mollie.com/reference/v2/customers-api/list-customers
  """
  @spec list(Client.t(), map | list) :: Molliex.response()
  def list(client, params \\ %{}) do
    get("v2/customers", client, params)
  end

  @doc """
  Retrieve a single customer by its ID.

  ## Example

      Molliex.Customers.find client, "cst_8wmqcHMN4U"

  More info at: https://docs.mollie.com/reference/v2/customers-api/get-customer
  """
  @spec find(Client.t(), binary, map | list) :: Molliex.response()
  def find(client, id, params \\ %{}) do
    get("v2/customers/#{id}", client, params)
  end

  @doc """
  Creates a customer.

  Customer body example
  ```
  %{
    "name" => "Customer A",
    "email" => "customer@example.com"
  }
  ```

  ## Example

      Molliex.Customers.create client, customer_body

  More info at: https://docs.mollie.com/reference/v2/customers-api/create-customer
  """
  @spec create(Client.t(), map) :: Molliex.response()
  def create(client, body) do
    post("v2/customers", client, body)
  end

  @doc """
  Update an existing customer.

  Customer body example
  ```
  %{
    "name" => "Customer Anderson",
    "email" => "customer_anderson@example.com",
    "locale" => "en_US"
  }
  ```

  ## Example

      Molliex.Customers.update client, "cst_8wmqcHMN4U", customer_body

  More info at: https://docs.mollie.com/reference/v2/customers-api/update-customer
  """
  @spec update(Client.t(), binary, map) :: Molliex.response()
  def update(client, id, body) do
    update("v2/customers/#{id}", client, body)
  end

  @doc """
  Delete a customer. All mandates and subscriptions created for this customer will be canceled as well.

  ## Example

      Molliex.Customers.remove client, "cst_8wmqcHMN4U"

  More info at: https://docs.mollie.com/reference/v2/customers-api/delete-customer
  """
  @spec remove(Client.t(), binary, map | list) :: Molliex.response()
  def remove(client, id, params \\ %{}) do
    delete("v2/customers/#{id}", client, params)
  end
end
