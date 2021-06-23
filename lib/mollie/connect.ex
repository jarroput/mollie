defmodule Mollie.Connect do
  import Mollie
  alias Mollie.Client

  @moduledoc """
  Mollie Connect is a set of APIs and tools that allows you to connect multiple Mollie accounts together.

  More info at: https://docs.mollie.com/connect/overview
  """

  @doc """
  Generates the authorization URL

  Params example
  ```
  %{
    "client_id" => "app_dnR5f6uPDWhrvZkiL9ex7Wjj",
    "state" => "a63f5cfcdaa209e2302be84da28008e8",
    "scope" => "payments.read payments.write profiles.read organizations.read",
    "response_type" => "code",
    "approval_prompt" => "auto",
    "redirect_uri" => "https://example.com"
  }
  ```

  ## Example

      Mollie.Connect.authorization_url client, params

  More info at: https://docs.mollie.com/reference/oauth2/authorize
  """
  @spec authorization_url(Client.t(), map | Keyword.t()) :: binary()
  def authorization_url(client, params) when is_map(params) do
    client
    |> url("oauth2/authorize")
    |> add_params_to_url(params)
  end

  def authorization_url(client, params) do
    map = Enum.into(params, %{})
    authorization_url(client, map)
  end

  @doc """
  Exchange the auth code received at the Authorize endpoint for an actual access token, with which you can communicate with the Mollie API.

  Token body example
  ```
  %{
    "grant_type" => "authorization_code",
    "code" => "auth_IbyEKUrXmGW1J8hPg6Ciyo4aaU6OAu"
  }
  ```

  ## Example

      Mollie.Connect.create_token client, token_body

  More info at: https://docs.mollie.com/reference/oauth2/tokens
  """
  @spec create_token(Client.t(), map) :: Mollie.response()
  def create_token(client, body) do
    post("oauth2/tokens", client, body)
  end

  @doc """
  Revoke an access- or a refresh token. Once revoked the token can not be used anymore.

  When you revoke a refresh token, all access tokens based on the same authorization grant will be revoked as well.

  Token body example
  ```
  %{
    "token_type_hint" => "access_token",
    "token" => "auth_IbyEKUrXmGW1J8hPg6Ciyo4aaU6OAu"
  }
  ```

  ## Example

      Mollie.Connect.revoke_token client, token_body

  More info at: https://docs.mollie.com/reference/oauth2/tokens
  """
  @spec revoke_token(Client.t(), map) :: Mollie.response()
  def revoke_token(client, body) do
    delete("oauth2/tokens", client, body)
  end
end
