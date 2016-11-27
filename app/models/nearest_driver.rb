class NearestDriver

  def self.getNearestDrivers(originLocation , driverList)

    driversWithDistance = Hash.new

    driverList.each do |driver|

      target_location = {lng: driver.longitude , lat: driver.latitude  }

      #working on pure distance , later we can change to google api route
      #distance = GoogleAPI.distance_considering_routes(originLocation, target_location)
      distance = LocationUtility.distance(originLocation, target_location)

      driversWithDistance[distance] = driver

    end

    driversWithDistance.sort_by { |k,v| k }.map {|k,v| v}

  end

end
