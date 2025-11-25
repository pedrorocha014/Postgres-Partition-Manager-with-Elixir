import Config

config :postgres_partition_manager, ecto_repos: [PostgresPartitionManager.Repo]

config :postgres_partition_manager, PostgresPartitionManager.Repo,
  database: "postgres",
  username: "postgres",
  password: "password",
  hostname: "localhost",
  port: 5435,
  pool_size: 10

