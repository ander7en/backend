class CreateDrivers < ActiveRecord::Migration[5.0]
  def change
    create_table :drivers do |t|
      t.string :firstName
      t.string :lastName
      t.float :longitude
      t.float :latitude
      t.string :carInfo
      t.float :pricePerKm
      t.email :email
      t.string :password

      t.timestamps
    end
  end
end
