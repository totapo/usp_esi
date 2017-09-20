class CreateMotorista < ActiveRecord::Migration[5.0]
  def change
    create_table :motorista do |t|
      t.string :nome
      t.string :cpf
      t.string :email
      t.string :telefone

      t.timestamps
    end
  end
end
