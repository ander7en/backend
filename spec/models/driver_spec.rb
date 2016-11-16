require 'rails_helper'

RSpec.describe Driver, type: :model do
  it "should return all existing drivers" do
    driverCount = 42
    for i in 0...driverCount do
      driver = build(:driver)
      driver.save!
    end

    allDrivers = Driver.all
    expect(allDrivers.size).to eq(driverCount)
  end

  it "should return only free drivers" do
    driverCount = 21
    freeDriverCount = 21
    for i in 0...driverCount do
      driver = build(:driver)
      driver.save!
    end
    for i in 0...freeDriverCount do
      driver = build(:driver, status: 1)
      driver.save!
    end

    freeDrivers = Driver.where(status: 0)
    expect(freeDrivers.size).to eq freeDriverCount
  end
end