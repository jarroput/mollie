defmodule Mollie.Profiles.Methods do
  import Mollie
  alias Mollie.Client

  @moduledoc """
  Enable or disable a payment method on a specific profile to use it with payments
  """

  @doc """
  Enables the payment method on the provided profile.
  This API is idempotent.

  ## Example

      Mollie.Profiles.Methods.enable client, "pfl_v9hTwCvYqw", "ideal"

  More info at: https://docs.mollie.com/reference/v2/profiles-api/enable-method
  """
  @spec enable(Client.t(), binary, binary) :: Mollie.response()
  def enable(client, id, method) do
    post("v2/profiles/#{id}/methods/#{method}", client)
  end

  @doc """
  Enables the payment method for the profile of the authenticated API key.

  This API is only available if [authenticated using an API key](https://docs.mollie.com/overview/authentication).

  This API is idempotent.

  ## Example

      Mollie.Profiles.Methods.enable client, "ideal"

  More info at: https://docs.mollie.com/reference/v2/profiles-api/enable-method
  """
  @spec enable(Client.t(), binary) :: Mollie.response()
  def enable(client, method) do
    post("v2/profiles/me/methods/#{method}", client)
  end

  @doc """
  Disables the payment method on the provided profile.

  ## Example

      Mollie.Profiles.Methods.disable client, "pfl_v9hTwCvYqw", "ideal"

  More info at: https://docs.mollie.com/reference/v2/profiles-api/disable-method
  """
  @spec disable(Client.t(), binary, binary) :: Mollie.response()
  def disable(client, id, method) do
    delete("v2/profiles/#{id}/methods/#{method}", client)
  end

  @doc """
  Disables the payment method on the provided profile.

  This API is only available if [authenticated using an API key](https://docs.mollie.com/overview/authentication).


  ## Example

      Mollie.Profiles.Methods.disable client, "ideal"

  More info at: https://docs.mollie.com/reference/v2/profiles-api/enable-method
  """
  @spec disable(Client.t(), binary) :: Mollie.response()
  def disable(client, method) do
    delete("v2/profiles/me/methods/#{method}", client)
  end
end
