defmodule ConnectTest do
  use ExUnit.Case
  doctest Mollie

  test "authorize_url with map" do
    client = Mollie.Client.new()

    params = %{
      "client_id" => "app_dnR5f6uPDWhrvZkiL9ex7Wjj",
      "state" => "a63f5cfcdaa209e2302be84da28008e8",
      "scope" => "payments.read payments.write profiles.read organizations.read",
      "response_type" => "code",
      "approval_prompt" => "auto",
      "redirect_uri" => "https://example.com"
    }

    authorization_url = Mollie.Connect.authorization_url(client, params)

    assert authorization_url ==
             "https://api.mollie.com/oauth2/authorize?approval_prompt=auto&client_id=app_dnR5f6uPDWhrvZkiL9ex7Wjj&redirect_uri=https%3A%2F%2Fexample.com&response_type=code&scope=payments.read+payments.write+profiles.read+organizations.read&state=a63f5cfcdaa209e2302be84da28008e8"
  end

  test "authorize_url with keyword list" do
    client = Mollie.Client.new()

    params = [
      response_type: "code",
      state: "a63f5cfcdaa209e2302be84da28008e8",
      client_id: "app_dnR5f6uPDWhrvZkiL9ex7Wjj",
      approval_prompt: "auto",
      scope: "payments.read payments.write profiles.read organizations.read",
      redirect_uri: "https://example.com"
    ]

    authorization_url = Mollie.Connect.authorization_url(client, params)

    assert authorization_url ==
             "https://api.mollie.com/oauth2/authorize?approval_prompt=auto&client_id=app_dnR5f6uPDWhrvZkiL9ex7Wjj&redirect_uri=https%3A%2F%2Fexample.com&response_type=code&scope=payments.read+payments.write+profiles.read+organizations.read&state=a63f5cfcdaa209e2302be84da28008e8"
  end
end
