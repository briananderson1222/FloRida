require_relative '../models/flow_model'
require_relative '../dao/flow_model_dao'
require_relative '../models/endpoint_node'
require_relative '../models/action_node'
require_relative '../util/env_reader'

env_file = (File.expand_path("..", __FILE__) + "/.env").gsub("/spec", "")
if File.exist?(env_file)
  EnvReader.instance.read_env(env_file)
end
