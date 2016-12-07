require 'rails_helper'

RSpec.describe DriverController, type: :controller do
  describe 'Driver Controller' do

    before(:all) do
      # Raatuse 22 coordinates
      @location = {lng: 58.382856, lat: 26.732627}
      @radius = 2000
      @number_of_drivers = 10
      DriverUtility.generate_drivers(@location, @number_of_drivers, @radius)
    end

    it 'returns json object' do
      get :nearby_drivers, params: {lng: 58.382856, lat: 26.732627}
      expect(response.content_type).to eq 'application/json'
    end

    it 'returns non empty list of json objects' do
      get :nearby_drivers, params: {lng: 58.382856, lat: 26.732627}
      expect(response).to be_success
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['drivers'].length).to be > 0
    end

    it 'returns list of objects containing expected keys' do
      get :nearby_drivers, params: {lng: 58.382856, lat: 26.732627}
      expect(response).to be_success
      parsed_response = JSON.parse(response.body)
      first_driver = parsed_response['drivers'][0]
      expect(first_driver.keys).to contain_exactly('lng', 'ltd', 'car_info')
    end

    after(:all) do
      Driver.delete_all
    end

  end

end
