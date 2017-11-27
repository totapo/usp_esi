class CreateBuses < ActiveRecord::Migration[5.0]
  def change
    create_table :buses do |t|
      t.string :plate
      t.string :model
      t.integer :nSeats
      t.belongs_to :driver, index: true
      t.belongs_to :line, index: true
      t.timestamps
    end
  end
end
