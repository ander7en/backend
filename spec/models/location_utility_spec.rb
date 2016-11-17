require 'rails_helper'

describe 'Location generator' do
  before(:all) do
    @location = {longitude: 26.7124793, latitude: 58.3782485}
    @radius = 2000
  end

  it 'should generate location within specified radius (as-the-crow-flies)' do
    generated_location = LocationUtility.generate_location(@location, @radius);
    actual_distance = LocationUtility.distance(@location,generated_location)
    expect(actual_distance).to be < @radius
  end

  it 'should generate specified number of locations' do
    size = 10
    generated_location_array = LocationUtility.generate_locations(@location, @radius, size)
    expect(generated_location_array.length).to eq(size)
  end

  it 'all locations should be within radius' do
    size = 10
    generated_location_array = LocationUtility.generate_locations(@location, @radius, size)
    generated_location_array.each { |generated_location|
      expect(LocationUtility.distance(@location, generated_location)).to be < @radius
    }
  end
end