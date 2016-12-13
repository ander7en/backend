#this should be asyncronous
class NotifyDriver


  def self.notify(driver_id,order_id)

    channel = DriverChannel.where(driver_id: driver_id).take

    if !channel.nil? && !channel.channel_id.nil?
    order = Order.where(id: order_id).take

    Pusher.trigger(channel.channel_id + '_channel', 'notify', {
        OrderInfo: {slat: order.source_latitude, slong: order.source_longitude,
                    tlat: order.dest_latitude, tlong: order.dest_longitude},
        OrderId: order_id
    })

    end

  end


  def self.driver_response(driver_id, response, order_id)

    if response
      #deleting all other driver but this
      #to do

      order = SetStatus.order(order_id,1)

      srcLocation = {lat: order.source_latitude, lng: order.source_longitude}

      driver = SetStatus.driver(driver_id,1)
      order.driver_id = driver.id
      order.save

      driverQuery = DriverQuery.where(driver_id: driver_id, order_id: order_id).take

      Pusher.trigger(driverQuery.user_channel_id + '_channel', 'update', {
          carInfo: driver.carInfo,
          arrivalTime: GoogleAPI.time_to_reach({lat: driver.latitude, lng: driver.longitude},
                                               srcLocation)
      })

    else
      user_channel_id = DriverQuery.where(driver_id: driver_id, order_id: order_id).take.user_channel_id
      #removing currently selected driver
      DriverQuery.where(driver_id: driver_id, order_id: order_id).take.destroy!
      #querying new driver

      next_driver = DriverQuery.where(order_id: order_id).take

      if next_driver.nil?
        Pusher.trigger(user_channel_id + '_channel', 'error',
                       {message: 'No available drivers for your order'})
      else
        NotifyDriver.notify(next_driver.id,order_id)
      end
    end
  end

end
