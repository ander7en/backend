class DriverQueryJob
  #include SuckerPunch::Job
  #make pusher notification to driver
  #take response from notification

  def self.perform (driverList)

    driverList.each do |t|

      if !driver.channel_id.nil?

      end  

    end

    driverList[0]
    #return Driver.where(id: driver_ids[0]).take
  end
end
