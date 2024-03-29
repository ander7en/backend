class DriverController < ApplicationController

  # def nearby_drivers

  #   lng = params[:lng].to_f
  #   lat = params[:lat].to_f

  #   if lng == 0.0 or lat == 0.0
  #     raise 'Bad Request'
  #   end

  #   nearby_drivers = DriverUtility.get_nearby_drivers({ :lng => lng, :lat => lat})

  #   # TODO ADD ENV CHECK IF IN DEMO MODE ONLY
  #   if nearby_drivers.empty?
  #     nearby_drivers = DriverUtility.generate_drivers({:lng => lng, :lat => lat}, 10, 2000)
  #   end

  #   drivers = []

  #   nearby_drivers.each do |driver|
  #     drivers.append({:lng => driver.longitude, :ltd => driver.latitude, :car_info=> driver.carInfo})
  #   end

  #   render :json => {:drivers => drivers}
  # end

  def login

      email = params[:email]
      password = params[:password]
      channel_id = params[:channelId]

      result = LoginDriver.login(email, password, channel_id)
      if result != 'incorrect username or password'
        render :json => {:text => result, wasSuccessful: 'success'}
      else
        render :json => {:text => result, wasSuccessful: 'fail'}
      end
  end

  def register_driver
    if (params.has_key?(:email) && params.has_key?(:password))
      first_name   = params[:first_name]
      last_name    = params[:last_name]
      email        = params[:email]
      password     = params[:password]
      car_info     = params[:carInfo]
      price_per_km = params[:price]

      result = RegisterNewDriver.register(first_name, last_name, email, password, car_info, price_per_km)

      render :json => {:text => result}

    else
      render :json => {:text => 'insufficient credentials!'}
    end
  end

  def update_driver_status

    driver_id = params[:driverId]
    status = params[:status]
    if status
      cur_location = params[:currentLocation]
    end
    result = LoginDriver.update_driver_status(driver_id, status, cur_location)

    render :json => {:text => result}

  end

  def logout

    driver_id = params[:driver_id]
    status = false

    result = LoginDriver.update_driver_status(driver_id, status)

    render :json => {:text => result}
  end


  def finish

    order_id = params[:orderId]

    result = NotifyDriver.finish_ride(order_id)
    render :json => {:text => result}

  end

end
