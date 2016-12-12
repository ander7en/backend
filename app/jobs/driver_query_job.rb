class DriverQueryJob
  #include SuckerPunch::Job
  #make pusher notification to driver
  #take response from notification

  def self.perform (driverList, order)

    driverList.each do |t|
      channel = DriverChannel.where(driver_id: t.id)
      if !channel.channel_id.nil?
        channel_id = channel.channel_id

        Pusher.trigger(channel_id + '_channel', 'notify', {
            OrderInfo: {slat: order.source_latitude, slong: order.source_longitude,
                        tlat: order.dest_latitude, tlong: order.source.longitude}
        })
        #get respone from pusher
        response = true;
        if response
            return t
        end
      end
     end
  end
end
