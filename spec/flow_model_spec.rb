require_relative 'spec_helper'

describe FlowModel do

  before :each do
    a = ActionNode.new('id', 'name', [], 'status', 'type', '3305196772')
    e = EndpointNode.new('id', 'name', [a], 'http://', 'GET', 'body', { 'Content-Type' => 'application/json' }, {  'q' => 'apple' })
    @flow = FlowModel.new(nil,"kelton", e)
  end

  describe '#print_nodes' do
    it 'flats the flow model' do
      puts @flow.flat.inspect
    end
  end

end
