defmodule Mollie.Orders do
  import Mollie
  alias Mollie.Client

  @moduledoc """
  Using the Orders API is the preferred approach when integrating the Mollie API into e-commerce applications such as webshops. If you want to use 'pay after delivery' methods such as Klarna Pay later, using the Orders API is mandatory.
  """

  @doc """
  Retrieve all orders. Results are paginated

  ## Example

      Mollie.Orders.list client

  More info at: https://docs.mollie.com/reference/v2/orders-api/list-orders
  """
  @spec list(Client.t(), map) :: Mollie.response()
  def list(client, params \\ %{}) do
    get("v2/orders", client, params)
  end

  @doc """
  Retrieve a single order by its ID.

  ## Example

      Mollie.Orders.find client, "ord_8wmqcHMN4U"

  More info at: https://docs.mollie.com/reference/v2/orders-api/get-order
  """
  @spec find(Client.t(), binary, map) :: Mollie.response()
  def find(client, id, params \\ %{}) do
    get("v2/orders/#{id}", client, params)
  end

  @doc """
  Creates an order.
  Creating an order will automatically create the required payment
  to allow your customer to pay for the order.
  Once you have created an order, you should redirect your customer to
  the URL in the `_links.checkout` property from the response.

  Order body example
  ```
  %{
      "amount" => %{
          "currency" => "EUR",
          "value" => "100.00"
      },
      "orderNumber" => "23302",
      "lines" => [
        %{
            "name" => "LEGO 4440 Forest Police Station",
            "quantity" => 1,
            "unitPrice" => %{
                "currency" => "EUR",
                "value" => "79.00"
            },
            "totalAmount" => %{
                "currency" => "EUR",
                "value" => "100.00"
            },
            "vatRate" => "21.00",
            "vatAmount" => %{
                "currency" => "EUR",
                "value" => "21.00"
            }
        }
      ],
      "billingAddress" => %{
        "givenName" => "Piet",
        "familyName" => "Mondriaan",
        "email" => "pm@example.com",
        "streetAndNumber" => "Keizersgracht 313",
        "city" => "Amsterdam",
        "region" => "Noord-Holland",
        "postalCode" => "1234AB",
        "country" => "NL",
      },
      "redirectUrl" => "https://example.com/redirect",
      "locale" => "nl_NL"
  }
  ```
  ## Example

      Mollie.Orders.create client, order_body

  More info at: https://docs.mollie.com/reference/v2/orders-api/create-order
  """
  @spec create(Client.t(), map) :: Mollie.response()
  def create(client, body) do
    post("v2/orders", client, body)
  end

  @doc """
  Update the billing and/or shipping address of an order.

  Update body example
  ```
  %{
      "shippingAddress" => %{
          "givenName" => "Piet",
          "familyName" => "Mondriaan",
          "email" => "pm@example.com",
          "streetAndNumber" => "Keizersgracht 313",
          "city" => "Amsterdam",
          "region" => "Noord-Holland",
          "postalCode" => "1234AB",
          "country" => "NL"
      }
  }
  ```

  ## Example

      Mollie.Orders.update client, "ord_8wmqcHMN4U", update_body

  More info at: https://docs.mollie.com/reference/v2/orders-api/update-order
  """
  @spec update(Client.t(), binary, map) :: Mollie.response()
  def update(client, id, body) do
    patch("v2/orders/#{id}", client, body)
  end

  @doc """
  Cancels the order if the order’s `status` field is either `created`, `authorized` or `shipping`.

  ## Example

      Mollie.Orders.cancel client, "ord_8wmqcHMN4U"

  More info at: https://docs.mollie.com/reference/v2/orders-api/cancel-order
  """
  @spec cancel(Client.t(), binary, map) :: Mollie.response()
  def cancel(client, id, params \\ %{}) do
    delete("v2/orders/#{id}", client, params)
  end
end
