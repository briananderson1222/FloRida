class FlowModel

  attr_accessor :name, :id, :initial_node_id

  def initialize(name, id, initial_node_id)
    @name = name
    @id = id
    @initial_node_id = initial_node_id
  end

  def run
  end

end
