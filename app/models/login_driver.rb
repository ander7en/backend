class LoginDriver

  def self.login(email, password)

    driver = Driver.where(email: email, password: password).take

    if !driver.nil?
        return driver.email
    else
      error = 'incorrect username or password'
      return error
    end
  end
end
