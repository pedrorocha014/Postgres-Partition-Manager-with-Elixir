defmodule PostgresPartitionManager.TransactionGenerator do
  @moduledoc """
  GenServer that generates fake transaction records and inserts them into the database.
  """
  use GenServer
  alias PostgresPartitionManager.Repo
  alias PostgresPartitionManager.Transaction

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    {:ok, %{}}
  end

  @doc """
  Creates multiple fake transaction records.
  """
  def create_transactions(1) do
    GenServer.call(__MODULE__, :create_transaction)
  end

  def create_transactions(count) when is_integer(count) and count > 0 do
    GenServer.call(__MODULE__, {:create_transactions, count})
  end

  @impl true
  def handle_call(:create_transaction, _from, state) do
    transaction = create_fake_transaction()
    
    case Repo.insert(transaction) do
      {:ok, inserted} ->
        {:reply, {:ok, inserted}, state}
      {:error, changeset} ->
        {:reply, {:error, changeset}, state}
    end
  end

  @impl true
  def handle_call({:create_transactions, count}, _from, state) do
    transactions_data = 
      1..count
      |> Enum.map(fn _ -> 
        transaction = create_fake_transaction()
        %{
          value: transaction.value,
          created_at: transaction.created_at,
          updated_at: transaction.updated_at
        }
      end)
    
    case Repo.insert_all(Transaction, transactions_data) do
      {inserted_count, _} when inserted_count > 0 ->
        {:reply, {:ok, inserted_count}, state}
      error ->
        {:reply, {:error, error}, state}
    end
  end

  defp create_fake_transaction do
    now = DateTime.utc_now() |> DateTime.truncate(:second)

    value = :rand.uniform() * 10000.0 |> Decimal.from_float() |> Decimal.round(2)
    
    %Transaction{
      value: value,
      created_at: now,
      updated_at: now
    }
  end
end

