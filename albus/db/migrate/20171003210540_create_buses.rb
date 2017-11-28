class CreateBuses < ActiveRecord::Migration[5.0]
  def change
    create_table :buses do |t|
      t.string :plate
      t.string :model
      t.integer :nSeats
      t.timestamps
    end
  end
end
