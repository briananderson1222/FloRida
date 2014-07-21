require_relative 'base_node'
require_relative '../util/service'

class EndpointNode < BaseNode

include Service

attr_accessor :url, :request_method, :body, :headers, :parameters

  def initialize(id, name, child_nodes, url, request_method, body, headers = {}, parameters = { })
    super(id, name, child_nodes)
    @url = url
    @request_method = request_method
    @body = body
    @headers = headers
    @parameters = parameters
  end

  def to_hash
    hash = super.to_hash
    hash['url'] = @url
    hash['request_method'] = request_method
    hash['body'] = body
    hash['headers'] = headers
    hash['parameters'] = parameters
    hash['node_type'] = 'endpoint'
    hash
  end

  def can_run(input)
    true
  end

  def run(input)
    puts input
    request = http_request(url, @request_method, @query_params, @headers, @body)
    response = {
      'status_code' => request.code,
      'headers' => request.headers,
      'query_parameters' => @query_parameters,
      'request_method' => @request_method,
      'url' => url
    }

    x = { 'response' => response }
    x
  end

  def self.child_nodes_to_hash(child_hash_arr)
    child_hash_arr.collect{|x|  x['node_type'] == 'endpoint' ? EndpointNode.from_hash(x) : ActionNode.from_hash(x) }
  end

  def self.from_hash(hash)
    children = self.child_nodes_to_hash(hash['child_nodes'])
    EndpointNode.new(hash['id'], hash['name'], children, hash['url'], hash['request_method'], hash['body'], hash['parameters'])
  end

end
