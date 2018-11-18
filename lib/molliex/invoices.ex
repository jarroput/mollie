defmodule Molliex.Invoices do
  import Molliex
  alias Molliex.Client

  @doc """
  Retrieve all invoices on the account. Optionally filter on year or invoice number.
  Results are paginated.

  ## Example

      Molliex.Invoices.list client

  More info at: https://docs.mollie.com/reference/v2/invoices-api/list-invoices
  """
  @spec list(Client.t(), map | list) :: Molliex.response()
  def list(client, params) do
    get("v2/invoices", client, params)
  end

  @doc """
  Retrieve details of an invoice, using the invoice’s identifier.

  ## Example

      Molliex.Invoices.find client, "inv_FrvewDA3Pr"

  More info at: https://docs.mollie.com/reference/v2/invoices-api/get-invoice
  """
  @spec find(Client.t(), binary) :: Molliex.response()
  def find(client, id) do
    get("v2/invoices/#{id}", client)
  end
end
