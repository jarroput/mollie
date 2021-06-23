defmodule Mollie.Invoices do
  import Mollie
  alias Mollie.Client

  @moduledoc """
  Retrieve details of an invoice. To retrieve details of an invoice by its invoice number, use `list/2`
  with the `reference` parameter.
  """

  @doc """
  Retrieve all invoices on the account. Optionally filter on year or invoice number.
  Results are paginated.

  ## Example

      Mollie.Invoices.list client

  More info at: https://docs.mollie.com/reference/v2/invoices-api/list-invoices
  """
  @spec list(Client.t(), map | list) :: Mollie.response()
  def list(client, params) do
    get("v2/invoices", client, params)
  end

  @doc """
  Retrieve details of an invoice, using the invoice’s identifier.

  ## Example

      Mollie.Invoices.find client, "inv_FrvewDA3Pr"

  More info at: https://docs.mollie.com/reference/v2/invoices-api/get-invoice
  """
  @spec find(Client.t(), binary) :: Mollie.response()
  def find(client, id) do
    get("v2/invoices/#{id}", client)
  end
end
