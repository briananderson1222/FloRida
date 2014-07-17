require 'twilio-ruby'

module SMS

  def send_text_message(to_number, message)
    client = Twilio::REST::Client.new(ENV['twilio_sid'], ENV['twilio_token'])
    client.account.sms.messages.create(:from => ENV['twilio_number'], :to => to_number, :body => message)
  end

end
