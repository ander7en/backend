class DriverController < ApplicationController

  def nearby_drivers

    lng = params[:lng].to_f
    ltd = params[:lat].to_f

    nearby_drivers = DriverUtility.get_nearby_drivers({ :lng => lng, :lat => ltd})

    drivers = []

    nearby_drivers.each do |driver|
      drivers.append({:lng => driver.longitude, :ltd => driver.latitude, :car_info=> driver.carInfo})
    end

    render :json => {:drivers => drivers}
  end

end
