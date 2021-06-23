defmodule Mollie.Orders.Shipments do
  import Mollie
  alias Mollie.Client

  @moduledoc """
  The Shipment API is used to ship order lines created by the Create order.

  The word 'shipping' is used in the figurative sense here. It can also mean that a service was provided or digital content was delivered.
  """

  @doc """
  Retrieve all shipments for an order.

  ## Example

      Mollie.Orders.Shipments.list client, "ord_8wmqcHMN4U"

  More info at: https://docs.mollie.com/reference/v2/shipments-api/list-shipments
  """
  @spec list(Client.t(), binary, map | list) :: Mollie.response()
  def list(client, order_id, params \\ %{}) do
    get("v2/orders/#{order_id}/shipments", client, params)
  end

  @doc """
  Retrieve a single shipment and the order lines shipped by a shipment’s ID.

  ## Example

      Mollie.Orders.Shipments.find client, "ord_8wmqcHMN4U", "shp_3wmsgCJN4U"

  More info at: https://docs.mollie.com/reference/v2/shipments-api/get-shipment
  """
  @spec find(Client.t(), binary, binary, map | list) :: Mollie.response()
  def find(client, order_id, id, params \\ %{}) do
    get("v2/orders/#{order_id}/shipments/#{id}", client, params)
  end

  @doc """
  Create a shipment to ship order lines.
  If an empty array is sent for `lines`, the entire order will be shipped.

  Shipment example body
  ```
  %{
    "lines" => []
  }
  ```

  ## Example

      Mollie.Orders.Shipments.create client, "ord_8wmqcHMN4U", shipment_body

  More info at: https://docs.mollie.com/reference/v2/shipments-api/create-shipment
  """
  @spec create(Client.t(), binary, map) :: Mollie.response()
  def create(client, order_id, body \\ %{}) do
    post("v2/orders/#{order_id}/shipments", client, body)
  end

  @doc """
  Update the tracking information of a shipment.

  Update example body
  ```
  %{
    "tracking" => %{
      "carrier" => "PostNL",
      "code" => "3SKABA000000000"
    }
  }
  ```

  ## Example

      Mollie.Orders.Shipments.update client, "ord_8wmqcHMN4U", "shp_3wmsgCJN4U", update_body

  More info at: https://docs.mollie.com/reference/v2/shipments-api/update-shipment
  """
  @spec update(Client.t(), binary, binary, map) :: Mollie.response()
  def update(client, order_id, id, body \\ %{}) do
    patch("v2/orders/#{order_id}/shipments/#{id}", client, body)
  end
end
