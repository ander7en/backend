class DriverQueryJob
  def self.perform (driverList, order, user_channel_id)
    driverList.each do |t|
    #save STATE TO DB
    driver_query = DriverQuery.new
    driver_query.user_channel_id = user_channel_id
    driver_query.driver_id = t.id
    driver_query.order = order.id

    end

    NotifyDriver.notify(driverList[0].id)

  end
end
