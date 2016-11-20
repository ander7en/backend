class Order < ApplicationRecord
  enum status: [:waiting, :serving, :finished]
end
