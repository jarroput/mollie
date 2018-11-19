defmodule ClientTest do
  use ExUnit.Case
  import Mollie.Client
  doctest Mollie

  test "default endpoint" do
    client = new()
    assert client.endpoint == "https://api.mollie.com/"
  end

  test "custom endpoint" do
    expected = "https://ghe.foo.com/api/v3/"

    creds  = %{api_key: "test_example"}

    client = new(creds, "https://ghe.foo.com/api/v3/")
    assert client.endpoint == expected

    client = new("https://ghe.foo.com/api/v3/")
    assert client.endpoint == expected
  end

  test "endpoint has trailing slash" do
    expected = "https://ghe.foo.com/api/v3/"

    client = new("https://ghe.foo.com/api/v3")
    assert client.endpoint == expected
  end
end
