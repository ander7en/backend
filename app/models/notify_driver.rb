#this should be asyncronous
class NotifyDriver


  def self.notify(driver_id)

    channel = DriverChannel.where(driver_id: driver_id).take

    if !channel.nil? && !channel.channel_id.nil?

    Pusher.trigger(channel_id + '_channel', 'notify', {
        OrderInfo: {slat: order.source_latitude, slong: order.source_longitude,
                    tlat: order.dest_latitude, tlong: order.dest_longitude},
        OrderId: order.id
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

      driverQuery = DriverQuery.where(driver_id: driver_id, order_id: order_id).take

      Pusher.trigger(driverQuery.user_channel_id + '_channel', 'update', {
          carInfo: driver.carInfo,
          arrivalTime: GoogleAPI.time_to_reach({lat: driver.latitude, lng: driver.longitude},
                                               srcLocation)
      })

    else
      #removing currently selected driver
      DriverQuery.where(driver_id: driver_id, order_id: order_id).destroy
      #querying new driver
      next_driver = DriverQuery.where(order_id: oreder_id).take 1
      NotifyDriver.notify(next_driver.id)
    end

  end

end
