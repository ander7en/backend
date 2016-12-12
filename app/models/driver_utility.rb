class DriverUtility

  def self.generate_drivers(src_location, number_of_drivers=1, radius = 2000)
    generated = []

    number_of_drivers.times do |x|
      driver = Driver.new
      driver.firstName = Faker::Name.first_name
      driver.lastName = Faker::Name.last_name
      fake_location = LocationUtility.generate_location(src_location, radius)
      driver.longitude = fake_location[:lng]
      driver.latitude = fake_location[:lat]
      driver.carInfo = "#{Faker::Number.number(3)} #{Faker::Lorem.characters(3)}"
      driver.pricePerKm = Faker::Number.between(1.0, 10.0)
      driver.status = :free
      driver.save

      generated.append(driver)
    end

    generated

  end


  def self.get_nearby_drivers(src_location, radius=2000)
    drivers = Driver.where(status: 0)
    drivers_in_radius = drivers.select { |element|
      LocationUtility.distance({lat: element.latitude, lng: element.longitude}, src_location) <= radius

    }
    drivers_in_radius
  end

end