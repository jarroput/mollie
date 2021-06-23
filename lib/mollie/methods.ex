defmodule Mollie.Methods do
  import Mollie
  alias Mollie.Client

  @moduledoc """
  Retrieve enabled payment methods for the authorized organization.
  To list all available payment methods use `list_all/2`.
  """

  @doc """
  List all enabled payment methods.

  ## Example

      Mollie.Methods.list client

  More info at: https://docs.mollie.com/reference/v2/methods-api/list-methods
  """
  @spec list(Client.t(), map) :: Mollie.response()
  def list(client, params \\ %{}) do
    get("v2/methods", client, params)
  end

  @doc """
  Retrieve a single method by its ID.
  Note that if a method is not available on the website profile a status 404 Not found is returned.
  When the method is not enabled, a status 403 Forbidden is returned.

  ## Example

      Mollie.Methods.find client, "ideal"

  More info at: https://docs.mollie.com/reference/v2/methods-api/get-method
  """
  @spec find(Client.t(), binary, map) :: Mollie.response()
  def find(client, id, params \\ %{}) do
    get("v2/methods/#{id}", client, params)
  end
end
