require 'sinatra'

use Rack::MethodOverride

set :protection, :origin_whitelist => ['*']
set :public_folder, File.expand_path("..", __FILE__) + "/UI/build"

get '/' do
  "Hello World"
end


before do
  headers 'Access-Control-Allow-Origin' => '*', 'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']
end
