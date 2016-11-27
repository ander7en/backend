class Driver < ApplicationRecord
  enum status: [:free, :busy]
  has_many :orders, foreign_key: 'driver_id', dependent: :restrict_with_exception
end
