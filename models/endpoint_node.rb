require_relative 'base_node'

class EndpointNode < BaseNode

attr_accessor :url, :request_method, :header, :parameters, :body, :child_nodes

  def initialize(url, request_method, body, name, child_nodes, header={}, parameters={})
    super(name, child_nodes)
    @url = url
    @request_method = request_method
    @body = body
    @name = name
    @header = header
    @parameters = parameters
  end

end
