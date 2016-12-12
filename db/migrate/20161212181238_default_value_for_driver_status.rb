class DefaultValueForDriverStatus < ActiveRecord::Migration[5.0]
  def change
    change_column :drivers, :status, :integer, :default => 1
  end
end
