class LocationUtility
  RADIUS = 6371e3 # Earth radius in meters

  def self.generate_locations(location, radius, number)
    result_locations = []
    for i in 0...number do
      result_locations.push(LocationUtility.generate_location(location, radius))
    end
    return result_locations
  end

  # Random location generation around given coordinates
  # http://gis.stackexchange.com/questions/25877/how-to-generate-random-locations-nearby-my-location
  def self.generate_location(location, radius)
    prng = Random.new

    radius_in_degrees = radius / radius_in_meters(location[:latitude])

    x0 = location[:longitude]
    y0 = location[:latitude]
    u = prng.rand
    v = prng.rand
    w = radius_in_degrees * Math.sqrt(u)
    t = 2 * Math::PI * v
    x = w * Math.cos(t)
    y1 = w * Math.sin(t)
    # x1 = x / Math.cos(y0) // do not uncomment, will generate locations outside radius

    found_longitude = x + x0
    found_latitude = y1 + y0
    return {latitude: found_latitude, longitude: found_longitude}
  end

  # Adjustment of meters in degrees according to latitude
  # https://knowledge.safe.com/articles/725/calculating-accurate-length-in-meters-for-lat-long.html
  def self.radius_in_meters(latitude)
    rlat = latitude * Math::PI/180
    meters_per_degree = 111392.92 - 559.82 * Math.cos(2 * rlat) + 1.175 * Math.cos(4 * rlat)
    return meters_per_degree
  end

  # This uses the ‘haversine’ formula to calculate the great-circle distance between two points – that is,
  # shortest distance over the earth’s surface – giving an ‘as-the-crow-flies’
  # http://www.movable-type.co.uk/scripts/latlong.html
  def self.distance(location1, location2)
    fi1 = location1[:latitude] * Math::PI / 180
    fi2 = location2[:latitude] * Math::PI / 180
    delta_fi = (location2[:latitude] - location1[:latitude]) * Math::PI / 180
    delta_lambda = (location2[:longitude] - location1[:longitude]) * Math::PI / 180

    a = Math.sin(delta_fi/2) * Math.sin(delta_fi/2) + Math.cos(fi1) * Math.cos(fi2) *
        Math.sin(delta_lambda/2) * Math.sin(delta_lambda/2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    d = RADIUS * c
    return d
  end
end