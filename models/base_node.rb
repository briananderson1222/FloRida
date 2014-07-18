class BaseNode

  attr_accessor :child_nodes, :id, :name

  def initialize(id, name, child_nodes)
    @name = name
    @child_nodes = child_nodes
    @id = id
  end

  def run
  end

  def to_hash
    child_hash = @child_nodes.collect{|x| x.to_hash }
    {
      'name' => @name,
      'child_nodes' => child_hash,
      'id' => id
    }
  end

end
