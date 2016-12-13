require 'net/http'
require 'json'

class GoogleAPI
  API_KEY = 'AIzaSyB_kcIgFuHeuQb0HQyyT2qUFA-VIqTA9iU'
  BASE_URL = 'https://maps.googleapis.com/maps/api/distancematrix/json?'
  GEOCODING_URL = 'https://maps.googleapis.com/maps/api/geocode/json?'
  GEOCODING_API_KEY = 'AIzaSyBCU-s39iVqUwF08l6ic2MIQqq79GXEI-s'
  FAIL_STRING = 'request to google maps api failed'

  def self.time_to_reach(src_loc, tgt_loc)
    uri = URI(BASE_URL)
    params = {:units => 'metric',
              :origins => "#{src_loc[:lat]},#{src_loc[:lng]}",
              :destinations => "#{tgt_loc[:lat]},#{tgt_loc[:lng]}",
              :key => API_KEY}
    uri.query = URI.encode_www_form(params)

    Net::HTTP.start(uri.host, uri.port,
                    :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new uri

      res = http.request request # Net::HTTPResponse object
      if res.is_a?(Net::HTTPSuccess)
        response_hash = JSON.parse(res.body.to_s, {:symbolize_names => true})
        return response_hash[:rows][0][:elements][0][:duration][:text]
      else
        return FAIL_STRING
      end
    end
  end

  def self.location_to_address(location)
    uri = URI(BASE_URL)
    params = {:latlng => "#{location[:lat]},#{location[:lng]}",
              :result_type => 'street_address',
              :key => GEOCODING_API_KEY}
    uri.query = URI.encode_www_form(params)

    Net::HTTP.start(uri.host, uri.port,
                    :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new uri

      res = http.request request # Net::HTTPResponse object
      if res.is_a?(Net::HTTPSuccess)
        response_hash = JSON.parse(res.body.to_s, {:symbolize_names => true})
        puts response_hash[:formatted_address]
        return response_hash[:formatted_address]
      else
        puts FAIL_STRING
        return FAIL_STRING
      end
    end
  end
end
