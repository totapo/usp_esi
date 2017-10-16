class AddGmapsToSpot < ActiveRecord::Migration[5.0]
  def change
    add_column :spots, :gmaps, :boolean
  end
end
