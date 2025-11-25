defmodule PostgresPartitionManager.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PostgresPartitionManager.Repo,
      PostgresPartitionManager.TransactionGenerator
    ]

    opts = [strategy: :one_for_one, name: PostgresPartitionManager.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

