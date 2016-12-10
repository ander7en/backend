class LoginDriver

  def self.login(email, password, channelId)

    driver = Driver.where(email: email, password: password).take

    if !driver.nil?
        #insert driver channel to db
        channel = DriverChannel.new
        channel.driver_id = driver.id
        channel.channel_id = channelId
        channel.save!
        return 'Success'
    else
      error = 'incorrect username or password'
      return error
    end
  end
end
