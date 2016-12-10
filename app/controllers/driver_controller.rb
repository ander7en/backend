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

  def login

      email = params[:email]
      password = params[:password]

      result = LoginDriver.login(email, password)

      render :json => {:text => result }

  end

  def register_driver
    if (params.has_key?(:email) && params.has_key?(:password))
      name         = params[:first_name]
      last_name    = params[:last_name]
      email        = params[:email]
      password     = params[:password]
      car_info     = params[:carInfo]
      price_per_km = params[:price]

      result = RegisterNewDriver.register(name, last_name, email, password, car_info, price_per_km)

      render :json => {:text => result}
      

    else
      render :json => {:text => 'insufficient credentials!'}
    end
  end

end
