class Driver < ApplicationRecord
  enum status: [:free, :busy]
end
