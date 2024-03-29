require 'rails_helper'
#require 'spec_helper'

RSpec.describe BookingController, :type => :controller do
  describe 'response' do
    it 'always returns json object' do
      post :create, params:
          {:source =>
               {:lng => '26.732116', :lat => '58.382482'},
           :target =>
               {:lng => '26.715456', :lat => '58.378217'},
           :format => :json}
      expect(response.content_type).to eq 'application/json'
    end

  end

end
