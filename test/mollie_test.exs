defmodule MollieTest do
  use ExUnit.Case, async: true

  defmodule ReqAgent do
    use Agent

    def start_link(), do: Agent.start_link(fn -> %{} end, name: __MODULE__)
    def inc(url), do: Agent.update(__MODULE__, &Map.update(&1, url, 1, fn v -> v + 1 end))
    def amount(url), do: Agent.get(__MODULE__, &Map.get(&1, url))
  end

  setup do
    client = Mollie.Client.new("", max_backoff: 50, base_backoff: 0)
    bypass = Bypass.open()
    client = %{client | endpoint: endpoint_url(bypass.port)}
    ReqAgent.start_link()
    {:ok, bypass: bypass, client: client}
  end

  describe "raw_request/5" do
    test "idempotency key is added with POST requests", %{bypass: bypass, client: client} do
      Bypass.expect(bypass, fn conn ->
        assert List.keyfind(conn.req_headers, "idempotency-key", 0)
        Plug.Conn.resp(conn, 200, "")
      end)

      Mollie.post("", client)
    end

    for status <- [500, 502, 503, 504] do
      test "response #{status} requests are retried for at least 5 times", %{
        bypass: bypass,
        client: client
      } do
        Bypass.expect(bypass, fn conn ->
          ReqAgent.inc(conn.request_path)
          assert List.keyfind(conn.req_headers, "idempotency-key", 0)
          Plug.Conn.resp(conn, unquote(status), "")
        end)

        Mollie.post("/"<> unquote(to_string(status)), client)

        assert ReqAgent.amount("/" <> unquote(to_string(status))) == 5
      end
    end

    for req <- ~w/get head put delete patch options/a do
      test "non idempotent methods are not retried: #{req}", %{bypass: bypass} do
        Bypass.expect(bypass, fn conn ->
          ReqAgent.inc(conn.request_path)
          refute List.keyfind(conn.req_headers, "idempotency-key", 0)
          Plug.Conn.resp(conn, 500, "")
        end)

        Mollie.raw_request(
          unquote(req),
          endpoint_url(bypass.port) <> "/" <> to_string(unquote(req))
        )

        assert ReqAgent.amount("/" <> unquote(to_string(req))) == 1
      end
    end
  end

  describe "post/2" do
    test "Idempotency-Key header is not overwritten", %{client: client, bypass: bypass} do
      client = %{
        client
        | options: Keyword.put(client.options, :idempotency_key, fn -> "mykey" end)
      }

      Bypass.expect(bypass, fn conn ->
        assert List.keyfind(conn.req_headers, "idempotency-key", 0)
        Plug.Conn.resp(conn, 200, "")
      end)

      Mollie.post("", client)
    end

    test "Idempotency-Key header is set by default", %{client: client, bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        assert List.keyfind(conn.req_headers, "idempotency-key", 0)
        Plug.Conn.resp(conn, 200, "")
      end)

      Mollie.post("", client)
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}"
end
