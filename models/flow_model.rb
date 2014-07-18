require_relative 'action_node'
require_relative 'endpoint_node'

class FlowModel

  attr_accessor :name, :id, :initial_node_id

  def initialize(id, name, initial_node)
    @name = name
    @id = id
    @initial_node = initial_node
  end

  def to_hash
    {
      'id' => @id,
      'name' => @name,
      'initial_node' => @initial_node.to_hash
    }
  end

  def self.from_hash(hash)
    FlowModel.new(hash['id'], hash['name'], hash['initial_node']['node_type'] == 'endpoint' ? EndpointNode.from_hash(hash['initial_node']) : ActionNode.from_hash(hash['initial_node']) )
  end


end
