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
      order.save
      drivers_in_radius = DriverUtility.get_nearby_drivers(srcLocation, 2000)
      if drivers_in_radius.length <= 0
        driver = DriverUtility.generate_drivers(srcLocation, 1, 2000)
        first_driver = driver[0]
        order.driver = first_driver
        drivers_in_radius.push(first_driver)
        order.status = 1
        order.save
        first_driver.status = 1
        first_driver.save
      else
        sorted_drivers = NearestDriver.getNearestDrivers(srcLocation, drivers_in_radius)
        DriverQueryJob.perform(sorted_drivers, order, userId)
      end
    end
  end
end
