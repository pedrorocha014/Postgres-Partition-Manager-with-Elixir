defmodule PostgresPartitionManager.Repo do
  use Ecto.Repo,
    otp_app: :postgres_partition_manager,
    adapter: Ecto.Adapters.Postgres
end

