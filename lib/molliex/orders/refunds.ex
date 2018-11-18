defmodule Molliex.Orders.Refunds do
  import Molliex
  alias Molliex.Client

  @doc """
  Retrieve all order refunds. Results are paginated

  ## Example

      Mollie.Orders.Refunds.list client, "ord_pbjz8x"

  More info at: https://docs.mollie.com/reference/v2/orders-api/list-order-refunds
  """
  @spec list(Client.t(), binary, map | list) :: Molliex.response()
  def list(client, order_id, params \\ %{}) do
    get("v2/orders/#{order_id}/refunds", client, params)
  end

  @doc """
  Creates a refund for an order line. Order lines that are `paid`, `shipping` or `completed` can be refunded.

  Refund body example
  ```
  %{
    "lines" => [
      %{
        "id" => "odl_dgtxyl"
      }
    ]
  }
  ```

  More info at: https://docs.mollie.com/reference/v2/orders-api/create-order-refund
  """
  @spec create(Client.t(), binary, map) :: Molliex.response()
  def create(client, order_id, body \\ %{}) do
    post("v2/orders/#{order_id}/refunds", client, body)
  end
end
