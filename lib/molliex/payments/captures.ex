defmodule Molliex.Payments.Captures do
  import Molliex
  alias Molliex.Client

  @doc """
  Retrieve all captures for a certain payment.

  ## Example

      Molliex.Payments.Captures.list client, "tr_7UhSN1zuXS"

  More info at: https://docs.mollie.com/reference/v2/captures-api/list-captures
  """
  @spec list(Client.t(), binary, map) :: Molliex.response()
  def list(client, payment_id, params \\ %{}) do
    get("v2/payments/#{payment_id}/captures", params)
  end

  @doc """
  Retrieve a single capture by its ID. Note the original payment’s ID is needed as well.

  ## Example

      Molliex.Payments.Captures.find client, "tr_7UhSN1zuXS", "cpt_4qqhO89gsT"

  More info at: https://docs.mollie.com/reference/v2/captures-api/get-capture
  """
  @spec find(Client.t(), binary, binary, map) :: Molliex.response()
  def find(client, payment_id, id, params \\ %{}) do
    get("v2/payments/#{payment_id}/captures/#{id}", params)
  end
end
