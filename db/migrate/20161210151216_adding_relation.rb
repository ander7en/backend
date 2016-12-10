class AddingRelation < ActiveRecord::Migration[5.0]
  def change
    add_reference(:driver_channels, :driver, foreign_key: true)
  end
end
