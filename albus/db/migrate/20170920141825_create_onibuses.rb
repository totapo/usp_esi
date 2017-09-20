class CreateOnibuses < ActiveRecord::Migration[5.0]
  def change
    create_table :onibuses do |t|
      t.string :placa
      t.string :modelo
      t.integer :nAcentos

      t.timestamps
    end
  end
end
