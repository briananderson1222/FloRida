require_relative 'spec_helper'

describe FlowModel do

  before :each do
    a = ActionNode.new('id_2', 'Text Message', [], 200, 'text', '3305196772')
    e = EndpointNode.new('id_1', 'name', [a], 'http://www.google.com', 'GET', '', {  }, {  })
    @flow = FlowModel.new(nil,"kelton", e)
  end

  describe '#run' do
    it 'flats the flow model' do
      @flow.run
    end
  end

end
