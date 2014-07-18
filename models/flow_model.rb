require_relative 'action_node'
require_relative 'endpoint_node'
require 'json'

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

  def print_nodes
    FlowModel.print_helper(@initial_node)
  end

  def self.print_helper(node)
    hash = node.to_hash
    hash_child_nodes = hash.delete('child_nodes')
    puts hash
    node.child_nodes.each do |x|
      FlowModel.print_helper(x)
    end
  end

  def flat
    big_arr = []
    addition =  []
    big_arr << addition
    FlowModel.flat_helper(@initial_node, big_arr, addition, nil)
    big_arr
  end

  def self.flat_helper(node, big_arr, addition, parent_id)
    hash = node.to_hash
    hash['parent_id'] = parent_id
    hash_child_nodes = hash.delete('child_nodes')
    addition << hash
    new_addition = []
    big_arr << new_addition
    node.child_nodes.each do |x|
      FlowModel.flat_helper(x, big_arr, new_addition, x.id)
    end
  end


  def self.from_hash(hash)
    FlowModel.new(hash['id'], hash['name'], hash['initial_node']['node_type'] == 'endpoint' ? EndpointNode.from_hash(hash['initial_node']) : ActionNode.from_hash(hash['initial_node']) )
  end


end
