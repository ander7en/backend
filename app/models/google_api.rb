require 'net/http'
require 'json'

class GoogleAPI
  API_KEY = 'AIzaSyB_kcIgFuHeuQb0HQyyT2qUFA-VIqTA9iU'
  BASE_URL = 'https://maps.googleapis.com/maps/api/distancematrix/json?'
  FAIL_STRING = 'request to google maps api failed'

  def self.time_to_reach(src_loc, tgt_loc)
    uri = URI(BASE_URL)
    params = {:units => 'metric',
              :origins => "#{src_loc[:latitude]},#{src_loc[:longitude]}",
              :destinations => "#{tgt_loc[:latitude]},#{tgt_loc[:longitude]}",
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
end