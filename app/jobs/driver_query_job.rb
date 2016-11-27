class DriverQueryJob 
  include SuckerPunch::Job
  
  def perform (driverList)
    # for the purpose of initial implementation
    driverList[0]
  end
end
