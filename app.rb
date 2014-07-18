require 'sinatra'
require 'json'

require_relative 'models/action_node'
require_relative 'models/endpoint_node'
require_relative 'util/env_reader'
require_relative 'models/flow_model'
require_relative 'dao/flow_model_dao'

use Rack::MethodOverride

set :protection, :origin_whitelist => ['*']
set :public_folder, File.expand_path("..", __FILE__) + "/UI/app"

include FlowModelDAO

get '/flowmodel/:flow_id/?' do
    flow = find_by_flow_id(params[:flow_id])
    headers({ 'content-type' => 'application/json' })
    JSON.generate(flow.to_hash)
end

post '/flowmodel/?' do
    flow = FlowModel.from_hash(JSON.parse(request.body.read))
    save_flow_model(flow)
    headers({ 'content-type' => 'application/json' })
    JSON.generate(flow.to_hash)
end

get '/flowmodel-flat/:flow_id/?' do
  flow = find_by_flow_id(params[:flow_id])
  headers({ 'content-type' => 'application/json' })
  JSON.generate(flow.flat)
end


before do
  headers 'Access-Control-Allow-Origin' => '*', 'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']
  EnvReader.instance.read_env
end
