class Driver < ApplicationRecord
  enum status: [:free, :busy]
  has_many :orders, foreign_key: "serving_driver", dependent: :restrict_with_exception
end
