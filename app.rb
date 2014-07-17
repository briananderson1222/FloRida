require 'sinatra'

require_relative 'models/action_node'
require_relative 'models/endpoint_node'
require_relative 'models/flow_model'

use Rack::MethodOverride

set :protection, :origin_whitelist => ['*']
set :public_folder, File.expand_path("..", __FILE__) + "/UI/build"

get '/' do
  node = FlowModel.new("sdfsd","dsfdsfds","fdsfdsfsd")
  puts node.inspect
end


before do
  headers 'Access-Control-Allow-Origin' => '*', 'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']
end
