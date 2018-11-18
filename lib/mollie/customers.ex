defmodule Mollie.Customers do
  import Mollie
  alias Mollie.Client

  @doc """
  Retrieve all customers created. Results are paginated.

  ## Example

      Mollie.Customers.list client

  More info at: https://docs.mollie.com/reference/v2/customers-api/list-customers
  """
  @spec list(Client.t(), map | list) :: Mollie.response()
  def list(client, params \\ %{}) do
    get("v2/customers", client, params)
  end

  @doc """
  Retrieve a single customer by its ID.

  ## Example

      Mollie.Customers.find client, "cst_8wmqcHMN4U"

  More info at: https://docs.mollie.com/reference/v2/customers-api/get-customer
  """
  @spec find(Client.t(), binary, map | list) :: Mollie.response()
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

      Mollie.Customers.create client, customer_body

  More info at: https://docs.mollie.com/reference/v2/customers-api/create-customer
  """
  @spec create(Client.t(), map) :: Mollie.response()
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

      Mollie.Customers.update client, "cst_8wmqcHMN4U", customer_body

  More info at: https://docs.mollie.com/reference/v2/customers-api/update-customer
  """
  @spec update(Client.t(), binary, map) :: Mollie.response()
  def update(client, id, body) do
    update("v2/customers/#{id}", client, body)
  end

  @doc """
  Delete a customer. All mandates and subscriptions created for this customer will be canceled as well.

  ## Example

      Mollie.Customers.remove client, "cst_8wmqcHMN4U"

  More info at: https://docs.mollie.com/reference/v2/customers-api/delete-customer
  """
  @spec remove(Client.t(), binary, map | list) :: Mollie.response()
  def remove(client, id, params \\ %{}) do
    delete("v2/customers/#{id}", client, params)
  end
end
