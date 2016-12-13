class SetStatus

  def self.order(order_id,status)

    order = Order.where(id: order_id).take
    if order
      order.status = status
      order.save!
      return order
    end

  end

  def self.driver(driver_id,status)

    driver = Driver.where(id: driver_id).take
    if driver
      driver.status = status
      driver.save!
      return driver
    end

  end

end
