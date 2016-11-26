class DriverQueryJob 
  include SuckerPunch::Job
  
  def perform (driverList)
    driverList[0]
  end
end
