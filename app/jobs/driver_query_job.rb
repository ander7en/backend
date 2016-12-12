class DriverQueryJob
  include SuckerPunch::Job
  #make pusher notification to driver
  #take response from notification
  #
  @driverList = nil
  def perform (driverList)
    # for the purpose of initial implementation
  #   @driverList = driverList
  #   driverList.each do |t|
  #
  #   puts t.firstName
  #   #channel = DriverChannel.where(driver_id: )
  # end
    
    driverList[0]
  end
end
