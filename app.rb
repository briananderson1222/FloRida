require 'sinatra'

require_relative 'models/action_node'
require_relative 'models/endpoint_node'
require_relative 'util/env_reader'
require_relative 'util/sms'
require_relative 'models/flow_model'

use Rack::MethodOverride

set :protection, :origin_whitelist => ['*']
set :public_folder, File.expand_path("..", __FILE__) + "/UI/app"

include SMS

get '/' do
  #send_text_message('(505) 803-5099', "I'm watching you Brian!")
  #node = EndpointNode.new("URL!!", "sadsad", 'name', [], {},{})
  #node = FlowModel.new("sdfsd","dsfdsfds","fdsfdsfsd")
  #puts node.inspect
end


before do
  headers 'Access-Control-Allow-Origin' => '*', 'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']
  EnvReader.instance.read_env
end
