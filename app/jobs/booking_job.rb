class BookingJob
  include SuckerPunch::Job
  @user_id
  @assigned_driver
  @src_location

  def perform(userId, srcLocation, tgtLocation)
    @user_id = userId
    @src_location = srcLocation
    ActiveRecord::Base.connection_pool.with_connection do
      order = Order.new
      order.source_longitude = srcLocation[:lng]
      order.source_latitude = srcLocation[:lat]
      order.dest_longitude = tgtLocation[:lng]
      order.dest_latitude = tgtLocation[:lat]
      order.status = 0
      drivers_in_radius = DriverUtility.get_nearby_drivers(srcLocation, 2000)
      if drivers_in_radius.length <= 0
        driver = DriverUtility.generate_drivers(srcLocation, 1, 2000)
        @assigned_driver = driver
        order.driver = @assigned_driver
        drivers_in_radius.push(driver)
      else
        sorted_drivers = NearestDriver.getNearestDrivers(srcLocation, drivers_in_radius)
        @assigned_driver = DriverQueryJob.perform(sorted_drivers, order)
        order.driver = @assigned_driver
      end
      order.status = 1
      order.save
      @assigned_driver.status = 1
      @assigned_driver.save
    end
    Pusher.trigger(@user_id + '_channel', 'update', {
        carInfo: @assigned_driver.carInfo,
        arrivalTime: GoogleAPI.time_to_reach({lat: @assigned_driver.latitude, lng: @assigned_driver.longitude},
                                             @src_location)
    })
  end
end
