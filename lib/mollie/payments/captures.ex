defmodule Mollie.Payments.Captures do
  import Mollie
  alias Mollie.Client

  @doc """
  Retrieve all captures for a certain payment.

  ## Example

      Mollie.Payments.Captures.list client, "tr_7UhSN1zuXS"

  More info at: https://docs.mollie.com/reference/v2/captures-api/list-captures
  """
  @spec list(Client.t(), binary, map) :: Mollie.response()
  def list(client, payment_id, params \\ %{}) do
    get("v2/payments/#{payment_id}/captures", client, params)
  end

  @doc """
  Retrieve a single capture by its ID. Note the original payment’s ID is needed as well.

  ## Example

      Mollie.Payments.Captures.find client, "tr_7UhSN1zuXS", "cpt_4qqhO89gsT"

  More info at: https://docs.mollie.com/reference/v2/captures-api/get-capture
  """
  @spec find(Client.t(), binary, binary, map) :: Mollie.response()
  def find(client, payment_id, id, params \\ %{}) do
    get("v2/payments/#{payment_id}/captures/#{id}", client, params)
  end
end
