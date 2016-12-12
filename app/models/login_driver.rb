class LoginDriver

  def self.login(email, password, channelId)

    driver = Driver.where(email: email, password: password).take

    if !driver.nil?
        #insert driver channel to db
        if DriverChannel.exists?(driver_id: driver.id)
          channel = DriverChannel.where(driver_id: driver.id)
          channel.channel_id = channelId
          channel.save!
          return driver.id
        else
          channel = DriverChannel.new
          channel.driver_id = driver.id
          channel.channel_id = channelId
          channel.save!
          return driver.id
        end
    else
      error = 'incorrect username or password'
      return error
    end
  end

  def self.update_driver_status(driver_id, status, cur_location)

    driver = Driver.where(id: driver_id).take
    if status then
      driver.latitude = cur_location[:lat]
      driver.longitude = cur_location[:lng]
      driver.save
      driver.free!
    else
      driver.busy!
    end
    return 'Success'

  end

end
