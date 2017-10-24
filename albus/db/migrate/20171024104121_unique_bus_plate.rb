class UniqueBusPlate < ActiveRecord::Migration[5.0]
  def change
    add_index :buses, [:plate], :unique => true
  end
end
