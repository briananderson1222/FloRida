require_relative 'base_node'

class ActionNode < BaseNode

attr_accessor :status, :type, :parameter

  def initialize(id, name, child_nodes, status, type, parameter)
    super(id, name, child_nodes)
    @status = status
    @type = type
    @parameter = parameter
  end

  def to_hash
    hash = super.to_hash
    hash['status'] = @status
    hash['type'] = type
    hash['parameter'] = parameter
    hash['node_type'] = 'action'
    hash
  end

  def self.from_hash(hash)
    children = self.child_nodes_to_hash(hash['child_nodes'])
    ActionNode.new(hash['id'], hash['name'], children, hash['status'], hash['type'], hash['parameter'])
  end

  def self.child_nodes_to_hash(child_hash_arr)
    child_hash_arr.collect{|x|  x['node_type'] == 'endpoint' ? EndpointNode.from_hash(x) : ActionNode.from_hash(x) }
  end



end
