defmodule Mollie.Profiles do
  import Mollie
  alias Mollie.Client

  @doc """
  Use this API if you are creating a plugin or SaaS application that allows users to enter a Mollie API key,
  and you want to give a confirmation of the website profile that will be used in your plugin or application.

  ## Example

      Mollie.Profiles.me client

  More info at: https://docs.mollie.com/reference/v2/profiles-api/get-profile-me
  """
  @spec me(Client.t()) :: Mollie.response()
  def me(client) do
    get("v2/profiles/me", client)
  end

  @doc """
  Retrieve all profiles available on the account.
  Results are paginated.

  ## Example

      Mollie.Profiles.list client

  More info at: https://docs.mollie.com/reference/v2/profiles-api/list-profiles
  """
  @spec list(Client.t()) :: Mollie.response()
  def list(client) do
    get("v2/profiles", client)
  end

  @doc """
  Retrieve details of a profile, using the profile’s identifier.

  ## Example

      Mollie.Profiles.find client, "pfl_v9hTwCvYqw"

  More info at: https://docs.mollie.com/reference/v2/profiles-api/get-profile
  """
  @spec find(Client.t(), binary) :: Mollie.response()
  def find(client, id) do
    get("v2/profiles/#{id}", client)
  end

  @doc """
  Create a website profile.

  Profile body example
  ```
  %{
    "name" => "Example Website",
    "website" => "https://www.example.com",
    "email" => "info@example.com",
    "phone" => "+31208202070"
  }
  ```

  ## Example

      Mollie.Profiles.create client, profile_body

  More info at: https://docs.mollie.com/reference/v2/profiles-api/create-profile
  """
  @spec create(Client.t(), map | list) :: Mollie.response()
  def create(client, body) do
    post("v2/profiles", client, body)
  end

  @doc """
  Update a website profile.

  For a body example see `create\2`.

  ## Example

      Mollie.Profiles.update client, "pfl_v9hTwCvYqw", profile_body

  More info at: https://docs.mollie.com/reference/v2/profiles-api/update-profile
  """
  @spec update(Client.t(), binary, map | list) :: Mollie.response()
  def update(client, id, body) do
    patch("v2/profiles/#{id}", client, body)
  end

  @doc """
  Deletes a profile, rendering it unavailable for further API calls and transactions.

  ## Example

      Mollie.Profiles.remove client, "pfl_v9hTwCvYqw"

  More info at: https://docs.mollie.com/reference/v2/profiles-api/delete-profile
  """
  @spec remove(Client.t(), binary) :: Mollie.response()
  def remove(client, id) do
    delete("v2/profiles/#{id}", client)
  end
end
