require 'rails_helper'

RSpec.describe Order, :type => :model do
 it "should return all orders" do
    driver = Driver.new
    driver.save!
    ordersCount = 11
    ordersCount.times do
      order = build(:order, driver: driver)
      order.save!
    end

    allOrders = Order.all
    expect(allOrders.size).to eq(ordersCount)
 end

 it "should return only waiting to process orders" do
   finishedOrders = 10
   waitingOrders = 4
   servingOrders = 21
   driver = Driver.new
   driver.save

   finishedOrders.times { build(:order, status: 2, driver: driver).save! }
   waitingOrders.times { build(:order, status: 0, driver: driver).save! }
   servingOrders.times { build(:order, status: 1, driver: driver).save! }

   waiting = Order.where(status: 0)
   expect(waiting.size).to eq(waitingOrders)
 end

end
