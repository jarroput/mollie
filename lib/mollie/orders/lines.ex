defmodule Mollie.Orders.Lines do
  import Mollie
  alias Mollie.Client

  @doc """
  Cancels a single or multiple order lines. Use `Mollie.Orders.cancel\3` to cancel
  an order completely.

  Cancel body example
  ```
  %{
    "lines" => [
      %{
        "id" => "odl_dgtxyl"
      }
    ]
  }
  ```

  ## Example

      Mollie.Orders.Lines.cancel client, "ord_8wmqcHMN4U", cancel_body

  More info at: https://docs.mollie.com/reference/v2/orders-api/cancel-order-lines
  """
  @spec cancel(Client.t(), binary, map) :: Mollie.response()
  def cancel(client, order_id, body \\ %{}) do
    delete("v2/orders/#{order_id}/lines", client, body)
  end
end
