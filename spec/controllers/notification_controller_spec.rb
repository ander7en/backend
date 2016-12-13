require 'rails_helper'

RSpec.describe NotificationController, type: :controller do
  describe 'Notification Controller' do
    # it "returns success message" do
    #   post :receive, params:
    #       {order_id: 1,response: true,driver_id: 1}
    #   parsed_response = JSON.parse(response.body)
    #   text = parsed_response['text']
    #   expect(text).to eq("Notification Recieved")
    #
    # end

    it "returns error in case of incorrect parameters" do
      post :receive, params:
          {order_id: 1,response: true}
      parsed_response = JSON.parse(response.body)
      text = parsed_response['text']
      expect(text).to eq("error")
    end

  end


end
