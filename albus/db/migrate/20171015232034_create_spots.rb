class CreateSpots < ActiveRecord::Migration[5.0]
  def change
    create_table :spots do |t|
      t.float :latitude
      t.float :longitude
      t.string :street_number
      t.string :route
      t.string :city
      t.string :country
      t.string :postal_code
      t.timestamps
    end
  end
end
