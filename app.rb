require 'sinatra'
require 'json'

require_relative 'models/action_node'
require_relative 'models/endpoint_node'
require_relative 'util/env_reader'
require_relative 'models/flow_model'
require_relative 'dao/flow_model_dao'

#use Rack::MethodOverride

#set :protection, :origin_whitelist => ['*']
set :protection, false
set :public_folder, File.expand_path("..", __FILE__) + "/UI/app"

include FlowModelDAO

get '/flowmodel-run/:flow_id/?' do
    flow = find_by_flow_id(params[:flow_id])
    flow.run
    headers({ 'content-type' => 'application/json' })
    JSON.generate({ 'status' => 'ok' })
end

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

get '/flowmodel-append/?' do
    flow = find_by_flow_id(params[:flow_id])
    child_node = params[:node_type] =='endpoint' ? EndpointNode.new(nil, params[:name], [], params[:url], params[:request_method], '', { },  { }) : ActionNode.new(nil, params[:name], [], params[:status].to_i, params[:type], params[:parameter])
    flow.insert_child_node(params[:parent_id], child_node)
    save_flow_model(flow)
    redirect '/flowmodel-flat/%s/' % [params[:flow_id]]
end

delete '/flowmodel-delete/?' do
    flow = find_by_flow_id(params[:flow_id])
    flow.delete_child_node(params[:child_id])
    redirect '/flowmodel-flat/%s/' % [params[:flow_id]]
end

get '/flowmodel-flat/:flow_id/?' do
  flow = find_by_flow_id(params[:flow_id])
  headers({ 'content-type' => 'application/json' })
  JSON.generate(flow.flat)
end


options '/flowmodel-append/?' do
    200
end

before do
  #if request.request_method == 'OPTIONS'
  #  response.headers["Access-Control-Allow-Origin"] = "*"
  #  response.headers["Access-Control-Allow-Methods"] = "POST"
  #  halt 200
  #end
  #Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept
 headers 'Access-Control-Allow-Origin' => '*',
           'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST'],
           'Access-Control-Allow-Headers' => 'Content-Type'
            EnvReader.instance.read_env
end
