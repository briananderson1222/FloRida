require_relative 'action_node'
require_relative 'endpoint_node'
require 'json'

class FlowModel

  attr_accessor :name, :id, :initial_node

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

  def insert_child_node(parent_id, child_node)
    if parent_id.nil?
      child_id = child_node.id.nil? ? (0...50).map { ('a'..'z').to_a[rand(26)] }.join : child_node.id
      child_node.id = child_id
      @initial_node = child_node
    else
      FlowModel.insert_child_helper(@initial_node,parent_id,child_node)
    end
  end

  def self.insert_child_helper(node,parent_id,child_node)
    if(node.id == parent_id)
      puts "FOUND"
      child_id = child_node.id.nil? ? (0...50).map { ('a'..'z').to_a[rand(26)] }.join : child_node.id
      child_node.id = child_id
      node.child_nodes << child_node
    end
    node.child_nodes.each do |x|
      FlowModel.insert_child_helper(x,parent_id,child_node)
    end
  end

  def delete_child_node(child_id)

    FlowModel.delete_child_helper(@initial_node,child_id)
  end

  def self.delete_child_helper(node,child_id)
    node.child_nodes.each do |x|
      if(x.id == child_id)
        node.child_nodes.delete(x)
      else
        FlowModel.delete_child_helper(x,parent_id,child_node)
      end
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
      FlowModel.flat_helper(x, big_arr, new_addition, node.id)
    end
  end


  def self.from_hash(hash)
    FlowModel.new(hash['id'], hash['name'], hash['initial_node']['node_type'] == 'endpoint' ? EndpointNode.from_hash(hash['initial_node']) : ActionNode.from_hash(hash['initial_node']) )
  end

  def run
    FlowModel.run_helper(@initial_node, nil)
  end

  def self.run_helper(node, input)
    if node.can_run(input)
      new_input = node.run(input)
      node.child_nodes.each do |child|
        FlowModel.run_helper(child, new_input)
      end
    end
end


end
