class DriverController < ApplicationController

  def nearby_drivers

    lng = params[:lng].to_f
    ltd = params[:ltd].to_f

    if lng == 0.0 or ltd == 0.0
      raise 'Bad Request'
    end

    nearby_drivers = DriverUtility.get_nearby_drivers({ :lng => lng, :lat => ltd})

    # TODO ADD ENV CHECK IF IN DEMO MODE ONLY
    if nearby_drivers.empty?
      nearby_drivers = DriverUtility.generate_drivers({:lng => lng, :lat => ltd}, 10, 2000)
    end

    drivers = []

    nearby_drivers.each do |driver|
      drivers.append({:lng => driver.longitude, :ltd => driver.latitude, :car_info=> driver.carInfo})
    end

    render :json => {:drivers => drivers}
  end

end
