class AddingEmailandPasswordtoDriver < ActiveRecord::Migration[5.0]
  def change
    add_column :drivers, :password, :string
    add_column :drivers, :email, :string
  end
end
