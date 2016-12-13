class DriverQueryJob
  def self.perform (driverList, order, user_channel_id)
    driverList.each do |t|
    #save STATE TO DB
    driver_query = DriverQuery.new
    driver_query.user_channel_id = user_channel_id
    driver_query.driver_id = t.id
    driver_query.order_id = order.id
    driver_query.save
    end

    NotifyDriver.notify(driverList[0].id, order.id)

  end
end
