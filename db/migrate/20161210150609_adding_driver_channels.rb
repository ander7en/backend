class AddingDriverChannels < ActiveRecord::Migration[5.0]
  def change
    create_table :driver_channels do |t|
      t.string :channel_id
    end
    
  end
end
