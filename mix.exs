defmodule PostgresPartitionManager.MixProject do
  use Mix.Project

  def project do
    [
      app: :postgres_partition_manager,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {PostgresPartitionManager.Application, []}
    ]
  end

  defp deps do
    [
      {:ecto_sql, "~> 3.11"},
      {:postgrex, "~> 0.18"},
      {:decimal, "~> 2.1"}
    ]
  end
end

