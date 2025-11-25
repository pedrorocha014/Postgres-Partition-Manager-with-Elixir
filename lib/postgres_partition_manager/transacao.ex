defmodule PostgresPartitionManager.Transaction do
  @moduledoc """
  Schema simple to represent a transaction.
  """
  use Ecto.Schema

  schema "transactions" do
    field :value, :decimal
    field :created_at, :utc_datetime
    field :updated_at, :utc_datetime
  end
end

