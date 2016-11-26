class ForeignKeyFromOrderToDriver < ActiveRecord::Migration[5.0]
  def change
    add_reference(:orders, :driver, foreign_key: true)
  end
end
