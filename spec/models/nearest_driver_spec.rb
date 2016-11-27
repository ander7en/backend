require 'rails_helper'

describe 'return sorted drivers by distance' do
  before(:all) do
    @originLocation = {lng: 26.7124793, lat: 58.3782485}
  end

  it 'should calculate and sort drivers by distance' do
    driver_kaubamaja = Driver.new
    driver_kaubamaja.firstName = 'kaubamajaDriver'
    driver_kaubamaja.longitude = 26.7257195
    driver_kaubamaja.latitude = 58.3777226

    driver_lounakeskus = Driver.new
    driver_lounakeskus.firstName = 'lonakeskusDriver'
    driver_lounakeskus.longitude = 26.6754045
    driver_lounakeskus.latitude = 58.3570084

    sorted_drivers_by_distance = NearestDriver.getNearestDrivers(@originLocation, [driver_lounakeskus, driver_kaubamaja])

    expect(sorted_drivers_by_distance).to eq([driver_kaubamaja, driver_lounakeskus])

  end


end
