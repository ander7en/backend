require 'digest/md5'

class RegisterNewDriver

  def self.register(first_name, last_name, email, password, car_info, price)

    new_driver = Driver.new
    new_driver.firstName = name
    new_driver.lastName = last_name
    new_driver.password = password #Digest::MD5.hexdigest(password)
    new_driver.email = email
    new_driver.carInfo = car_info
    new_driver.pricePerKm = price

    new_driver.save!

    return new_driver.persisted?

  end

end
