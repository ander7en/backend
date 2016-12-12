require 'rails_helper'

describe 'Location Utility' do
  before(:all) do
    # Raatuse 22 coordinates
    @location = {lng: 58.382856, lat: 26.732627}
    @radius = 2000
    @number_of_drivers = 10
  end
  describe 'function generate_drivers' do
    it 'should generate drivers within specified radius' do
      generated_drivers = DriverUtility.generate_drivers(@location, @number_of_drivers, @radius)
      generated_driver_location = {lng: generated_drivers[0][:longitude], lat: generated_drivers[0][:latitude]}
      actual_distance = LocationUtility.distance(@location,generated_driver_location)
      expect(actual_distance).to be < @radius
      expect(generated_drivers.length).to be @number_of_drivers
    end

    it 'should generate specified number of driver' do
      size = 10
      generated_driver_array = DriverUtility.generate_drivers(@location, size, @radius)
      expect(generated_driver_array.length).to eq(size)
    end

    it 'should generate all locations should be within radius' do
      generated_driver_array = DriverUtility.generate_drivers(@location, @number_of_drivers, @radius)
      generated_driver_array.each { |generated_driver|
        generated_driver_location = {lng: generated_driver[:longitude], lat: generated_driver[:latitude]}
        expect(LocationUtility.distance(@location, generated_driver_location)).to be < @radius
      }
    end
  end
  describe 'function get_nearby_drivers' do
    it 'should select 0 drivers' do
      drivers = Driver.all
      expect(drivers.length).to be 0
    end

    it 'should generate 10 drivers and select 10 drivers in the radius' do
      generated_drivers = DriverUtility.generate_drivers(@location, @number_of_drivers, @radius)
      selected_drives = Driver.all
      expect(selected_drives.length).to be @number_of_drivers
      expect(generated_drivers.length).to be @number_of_drivers
    end

    it 'should generate 10 drivers and function should also return 10 drivers' do
      generated_drivers = DriverUtility.generate_drivers(@location, @number_of_drivers, @radius)
      nearby_drives = DriverUtility.get_nearby_drivers(@location, @radius)
      expect(nearby_drives.length).to be @number_of_drivers
      expect(generated_drivers.length).to be @number_of_drivers
    end

  end


end