import Config

import_config "#{config_env()}.exs"
config :piedra_papel_tijera, database: "rest_api_db"
config :piedra_papel_tijera, pool_size: 3
