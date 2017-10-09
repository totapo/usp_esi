class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :cpf
      t.string :email
      t.string :telephone
      t.string :password
      t.timestamps
    end
  end
end
