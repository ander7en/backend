require 'pusher-client'

class DriverQueryJob
  #include SuckerPunch::Job
  #make pusher notification to driver
  #take response from notification

  def self.perform (driverList, order)

    options = { secure: true, app_id: '270304',secret: '3b445a7d57a435cace74',cluster: 'eu',encrypted: true }
    socket = PusherClient::Socket.new("cad5312b266942c7cf7d", options)

    driverList.each do |t|
      channel = DriverChannel.where(driver_id: t.id).take

      if !channel.nil? && !channel.channel_id.nil?
        channel_id = channel.channel_id

        Pusher.trigger(channel_id + '_channel', 'notify', {
            OrderInfo: {slat: order.source_latitude, slong: order.source_longitude,
                        tlat: order.dest_latitude, tlong: order.dest_longitude}
        })
        #get respone from pusher
        #client-response
        socket.subscribe(channel_id, '270304')
        socket.bind('client-response') do |data|
          puts data
        end

        socket.connect


        response = true;
        if response
            return t
        end
      else
        return driverList[0]
      end
     end
  end
end
