class DriverQueryTableCreation < ActiveRecord::Migration[5.0]
  def change
    create_table :driver_query do |t|
      t.string :user_channel_id
      t.integer :driver_id
      t.integer :order_id
      t.timestamps
    end
  end
end
