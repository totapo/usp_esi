class CreateDrivers < ActiveRecord::Migration[5.0]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :cpf
      t.string :email
      t.string :telephone
      t.timestamps
    end
  end
end
