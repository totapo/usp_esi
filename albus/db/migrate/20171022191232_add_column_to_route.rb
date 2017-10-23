class AddColumnToRoute < ActiveRecord::Migration[5.0]
  def change
    add_column :routes, :line_id, :integer
    add_column :routes, :spot_id, :integer
    add_column :routes, :order, :integer
  end
end
