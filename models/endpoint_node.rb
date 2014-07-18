require_relative 'base_node'

class EndpointNode < BaseNode

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

  def self.child_nodes_to_hash(child_hash_arr)
    child_hash_arr.collect{|x|  x['node_type'] == 'endpoint' ? EndpointNode.from_hash(x) : ActionNode.from_hash(x) }
  end

  def self.from_hash(hash)
    children = self.child_nodes_to_hash(hash['child_nodes'])
    EndpointNode.new(hash['id'], hash['name'], children, hash['url'], hash['request_method'], hash['body'], hash['parameters'])
  end

end
