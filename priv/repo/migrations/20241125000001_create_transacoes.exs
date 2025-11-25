defmodule PostgresPartitionManager.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :value, :decimal, precision: 15, scale: 2
      add :created_at, :utc_datetime
      add :updated_at, :utc_datetime
    end
  end
end

