require_relative 'base_node'

class ActionNode < BaseNode

attr_accessor :status, :type, :parameter

  def initialize(name, status, type, parameter, child_nodes = [])
    super(name, child_nodes)
    @status = status
    @type = type
    @parameter = parameter
  end

end
