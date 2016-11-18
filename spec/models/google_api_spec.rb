require 'rails_helper'

describe 'Google distance matrix API' do
  before(:all) do
    @src_location = {longitude: 26.732116, latitude: 58.382482} # Raatuse 22
    @tgt_location = {longitude: 26.715456, latitude: 58.378217} # Juhan Liivi 2
  end

  it 'should receive response from google api' do
    stub_request(:get, /.*maps\.googleapis\.com.*/).
        to_return(:status => 400)
    response = GoogleAPI.time_to_reach(@src_location, @tgt_location)
    expect(response).not_to be_empty
  end

  it 'should receive failure response' do
    stub_request(:get, /.*maps\.googleapis\.com.*/).
        to_return(:status => 400)
    response = GoogleAPI.time_to_reach(@src_location, @tgt_location)
    expect(response).to eq GoogleAPI::FAIL_STRING
  end

  it 'should receive success response' do
    result = File.read('/home/andrii/project/backend/spec/fake_responses/fake_google_api_response.json')
    stub_request(:get, /.*maps\.googleapis\.com.*/).
        to_return(:status => 200, :body => result)
    response = GoogleAPI.time_to_reach(@src_location, @tgt_location)
    expect(response).to eq '7 mins'
  end
end