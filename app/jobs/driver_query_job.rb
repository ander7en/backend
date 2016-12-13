class DriverQueryJob
  def self.perform (driver_list, order, user_channel_id)

    driver_list.each do |t|
      puts "Creating Driver Query #{t.id}"
      driver_query = DriverQuery.new
      driver_query.user_channel_id = user_channel_id
      driver_query.driver_id = t.id
      driver_query.order_id = order.id
      driver_query.save
    end

    puts "Queries Created"
    NotifyDriver.notify(order)

  end
end
