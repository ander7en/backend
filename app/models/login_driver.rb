class LoginDriver

  def self.login(email, password, driverId)

    driver = Driver.where(email: email, password: password).take

    if !driver.nil?

        return 'Success'
    else
      error = 'incorrect username or password'
      return error
    end
  end
end
