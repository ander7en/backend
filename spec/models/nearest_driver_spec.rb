require 'rails_helper'

describe 'return sorted drivers by distance' do
  before(:all) do
    @originLocation = {longitude: 26.7124793, latitude: 58.3782485}
  end

  it "should calculate and sort drivers by distance" do
    driverKaubamaja = Driver.new
    driverKaubamaja.firstName = 'kaubamajaDriver'
    driverKaubamaja.longitude = 26.7257195
    driverKaubamaja.latitude = 58.3777226

    driverLounakeskus = Driver.new
    driverLounakeskus.firstName = 'lonakeskusDriver'
    driverLounakeskus.longitude = 26.6754045
    driverLounakeskus.latitude = 58.3570084


    sortedDriversByDistance = NearestDriver.getNearestDrivers(@originLocation , [driverLounakeskus , driverKaubamaja])

    sortedDriversByDistance.should eq [driverKaubamaja , driverLounakeskus]

  end


end
