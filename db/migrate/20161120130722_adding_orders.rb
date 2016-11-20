class AddingOrders < ActiveRecord::Migration[5.0]
  def change
    create_table "orders", force: :cascade do |t|
      t.float "source_longitude"
      t.float "source_latitude"
      t.float "dest_longitude"
      t.float "dest_latitude"
      t.integer "status"
      t.integer "serving_driver"
    end
  end
end
