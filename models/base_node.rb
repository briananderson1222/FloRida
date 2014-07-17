class BaseNode

  attr_accessor :child_nodes, :id

  def initialize(name, child_nodes)
    @name = name
    @child_nodes = child_nodes
  end

  def run
  end

end
