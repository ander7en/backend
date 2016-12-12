require 'digest/md5'

class RegisterNewDriver

  def self.register(first_name, last_name, email, password, car_info, price)

    if Driver.where(email: email).any?
      return 'Driver with that email is already registered'
    end
    new_driver = Driver.new
    new_driver.firstName = first_name
    new_driver.lastName = last_name
    new_driver.password = password #Digest::MD5.hexdigest(password)
    new_driver.email = email
    new_driver.carInfo = car_info
    new_driver.pricePerKm = price

    new_driver.save!

    if new_driver.persisted?
        return 'Success'
      else
        return 'Error during registration'
    end

  end

end
