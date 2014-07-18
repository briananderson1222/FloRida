require_relative 'spec_helper'

include FlowModelDAO

describe FlowModel do

  before :each do
    base_url = 'https://mocksolstice.herokuapp.com/florida/awesome/play/'
    login_url = base_url + 'login'
    friends_url = base_url + 'friends'
    #phone = '8479514857'
    phone = '3305196772'

    a1 = ActionNode.new('a1', 'Login 500 Response Text Message', [], 500, 'text', phone)

    a3 = ActionNode.new('a3', '500 Friends Failure Text Message', [], 500, 'text', phone)

    e2 = EndpointNode.new('e2', 'Find Friends', [a3], friends_url, 'GET', '', {  }, {  })
    a2 = ActionNode.new('a2', 'Login 200 Response', [e2], 200, nil, nil)


    e1 = EndpointNode.new('e1', 'name', [a1, a2], login_url, 'POST', '', {  }, {  })

    @flow = FlowModel.new(nil,"kelton", e1)
    out = save_flow_model(@flow)
    puts out.inspect

  end

  describe '#run' do
    it 'flats the flow model' do
      @flow.run
    end
  end

end
