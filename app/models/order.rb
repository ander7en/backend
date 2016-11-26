class Order < ApplicationRecord
  enum status: [:waiting, :serving, :finished]
  belongs_to :driver, class_name: "Driver"
end
