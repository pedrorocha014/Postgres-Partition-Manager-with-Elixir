Application.ensure_all_started(:postgres_partition_manager)

Process.sleep(100)

transactions_count = 1000

IO.puts("Generating #{transactions_count} transaction(s)...")

result = 
  transactions_count
  |> PostgresPartitionManager.TransactionGenerator.create_transactions()

case result do
  {:ok, inserted} when is_integer(inserted) ->
    IO.puts("✓ Successfully created #{inserted} transaction(s)")
  {:ok, transaction} ->
    IO.puts("✓ Successfully created transaction with ID: #{transaction.id}")
  {:error, error} ->
    IO.puts("✗ Error creating transaction(s): #{inspect(error)}")
    System.halt(1)
end
