require 'sinatra'

require_relative 'models/action_node'
require_relative 'models/endpoint_node'
require_relative 'util/env_reader'
require_relative 'util/sms'
require_relative 'models/flow_model'
require_relative 'dao/flow_model_dao'

use Rack::MethodOverride

set :protection, :origin_whitelist => ['*']
set :public_folder, File.expand_path("..", __FILE__) + "/UI/build"

include SMS
include FlowModelDAO

get '/' do

  #send_text_message('(505) 803-5099', "I'm watching you Brian!")
  #node = EndpointNode.new('id', 'name', ['a', 'b'], 'http://', 'GET', body, { 'Content-Type' => 'application/json' }, {  'q' => 'apple' })
  #node1 = EndpointNode.new('id', 'name', [], 'http://', 'GET', body, { 'Content-Type' => 'application/json' }, {  'q' => 'apple' })

  #node = ActionNode.new('id', 'name', [node1], 'status', 'type', '3305196772')

  a = ActionNode.new('id', 'name', [], 'status', 'type', '3305196772')
  e = EndpointNode.new('id', 'name', [a], 'http://', 'GET', body, { 'Content-Type' => 'application/json' }, {  'q' => 'apple' })

  #puts EndpointNode.from_hash(e.to_hash).inspect

  #puts ActionNode.from_hash(node.to_hash).inspect
  #puts ActionNode.from_hash(node.to_hash).inspect


  flow = FlowModel.new(nil,"kelton", e)
  save_flow_model(flow)

end


before do
  headers 'Access-Control-Allow-Origin' => '*', 'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']
  EnvReader.instance.read_env
end
