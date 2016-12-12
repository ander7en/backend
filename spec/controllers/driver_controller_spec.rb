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

    it 'registers returns error message' do
      post :register_driver, params: {first_name: 'John', last_name: 'Doe'}
      expect(response).to be_success
      parsed_response = JSON.parse(response.body)
      status = parsed_response['text']
      expect(status).to eq('insufficient credentials!')
    end

    it 'registers driver' do
      post :register_driver, params: {first_name: 'John', last_name: 'Doe', email: 'john@doe.com',
                                      password: 'testpass', car_info: 'M1', price: '5'}
      expect(response).to be_success
      parsed_response = JSON.parse(response.body)
      status = parsed_response['text']
      expect(status).to eq('Success')

    end

    it 'returns error when driver is trying to register with email which was already used' do
      post :register_driver, params: {first_name: 'John', last_name: 'Doe', email: 'john@doe.com',
                                      password: 'testpass', car_info: 'M1', price: '5'}
      expect(response).to be_success
      parsed_response = JSON.parse(response.body)
      status = parsed_response['text']
      expect(status).to eq('Success')
      post :register_driver, params: {first_name: 'John', last_name: 'Doe', email: 'john@doe.com',
                                            password: 'testpass', car_info: 'M1', price: '5'}
      expect(response).to be_success
      parsed_response = JSON.parse(response.body)
      status = parsed_response['text']
      expect(status).to eq('Driver with that email is already registered')


    end

    it 'logins driver after registration' do
      post :register_driver, params: {first_name: 'John', last_name: 'Doe', email: 'john@doe.com',
                                      password: 'testpass', car_info: 'M1', price: '5'}
      expect(response).to be_success
      post :login, params: {email: 'john@doe.com', password: 'testpass'}
      expect(response).to be_success
      parsed_response = JSON.parse(response.body)
      result = parsed_response['text']
      expect(result).to be_instance_of Fixnum
    end

    it 'updates driver status' do
      post :register_driver, params: {first_name: 'John', last_name: 'Doe', email: 'john@doe.com',
                                      password: 'testpass', car_info: 'M1', price: '5'}
      expect(response).to be_success
      post :login, params: {email: 'john@doe.com', password: 'testpass'}
      expect(response).to be_success
      parsed_response = JSON.parse(response.body)
      driver_id = parsed_response['text']
      post :update_driver_status, params: {driverId: driver_id, status: "free"}
      expect(response).to be_success
      parsed_response = JSON.parse(response.body)
      result = parsed_response['text']
      expect(result).to eq('Success')
      driver = Driver.where(id: driver_id).take
      expect(driver.status).to eq("free")

    end

    it 'stores driver channel_id' do
      post :register_driver, params: {first_name: 'John', last_name: 'Doe', email: 'john@doe.com',
                                      password: 'testpass', car_info: 'M1', price: '5'}
      expect(response).to be_success
      post :login, params: {email: 'john@doe.com', password: 'testpass', channelId: 'gg11' }
      expect(response).to be_success
      driver = Driver.where(email: 'john@doe.com').take
      channel = DriverChannel.where(driver_id: driver.id).take
      expect('gg11').to eq(channel.channel_id)
    end

    it 'returns error message if credentials are incorrect' do
      post :register_driver, params: {first_name: 'John', last_name: 'Doe', email: 'john@doe.com',
                                      password: 'testpass', car_info: 'M1', price: '5'}
      expect(response).to be_success
      post :login, params: {email: 'ijohn@doe.com', password: 'testpass'}
      expect(response).to be_success
      parsed_response = JSON.parse(response.body)
      text = parsed_response['text']
      expect(text).to eq('incorrect username or password')

    end

    after(:all) do
      Driver.delete_all
      DriverChannel.delete_all
    end

  end

end
