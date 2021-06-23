defmodule Mollie.Onboarding do
  import Mollie
  alias Mollie.Client

  @moduledoc """
  Rertrieve or submit data that is used for onboarding organizations onto your merchant account. Please note that the data you submit will only be processed when the onboarding status is `needs-data`.
  """

  @doc """
  Get the status of onboarding of the authenticated organization

  ## Example

      Mollie.Onboarding.me client

  More info at: https://docs.mollie.com/reference/v2/onboarding-api/get-onboarding-status
  """
  @spec me(Client.t()) :: Mollie.response()
  def me(client) do
    get("v2/onboarding/me", client)
  end

  @doc """
  Submit data that will be prefilled in the merchant's onboarding.
  Please note that the data you submit will only be processed when the onboarding status is `needs-data`.

  Onboarding body example
  ```
  %{
    "organization" => %{
      "name" => "Mollie B.V.",
      "address" => %{
          "streetAndNumber" => "Keizersgracht 313",
          "postalCode" => "1018 EE",
          "city" => "Amsterdam",
          "country" => "NL"
      },
      "registrationNumber" => "30204462",
      "vatNumber" => "NL815839091B01"
    },
    "profile" => %{
      "name" => "Mollie",
      "url" => "https =>//www.mollie.com",
      "email" => "info@mollie.com",
      "phone" => "+31208202070",
      "categoryCode" => 6012
    }
  }
  ```

  ## Example

      Mollie.Onboarding.submit client, onboarding_body

  More info at: https://docs.mollie.com/reference/v2/onboarding-api/submit-onboarding-data
  """
  def submit(client, params \\ %{}) do
    post("v2/onboarding/me", client, params)
  end
end
