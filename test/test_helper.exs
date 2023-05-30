Supervisor.start_link([Mollie.child_spec()], strategy: :one_for_one)
ExUnit.start()
