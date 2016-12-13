#this should be asyncronous
class NotifyDriver


  def self.notify(order)

    #querying new driver
    driver_query = DriverQuery.where(order_id: order.id).take

    channel = DriverChannel.where(driver_id: driver_query.driver_id).take

    if !channel.nil? && !channel.channel_id.nil?

    Pusher.trigger(channel.channel_id + '_channel', 'notify', {
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

      src_location = {lat: order.source_latitude, lng: order.source_longitude}

      driver = SetStatus.driver(driver_id,1)

      driver_query = DriverQuery.where(driver_id: driver_id, order_id: order_id).take
      order.driver_id = driver_id
      order.save

      Pusher.trigger(driver_query.user_channel_id + '_channel', 'update', {
          carInfo: driver.carInfo,
          arrivalTime: GoogleAPI.time_to_reach({lat: driver.latitude, lng: driver.longitude},
                                               src_location)
      })

    else
      #removing currently selected driver
      dq = DriverQuery.where(driver_id: driver_id, order_id: order_id).take
      dq.destroy

      order = Order.find(order_id)
      NotifyDriver.notify(order)
    end

  end

end
