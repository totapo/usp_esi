class AddColumnToBuses < ActiveRecord::Migration[5.0]
  def change

    add_column :buses, :driver_id, :integer, index: true
    add_column :buses, :line_id, :integer, index: true
  end
end
