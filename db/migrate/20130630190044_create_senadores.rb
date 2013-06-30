class CreateSenadores < ActiveRecord::Migration
  def change
    create_table :senadores do |t|
      t.string :nome, null: :false
      t.date :nascimento, null: :false
      t.string :partido, null: :false
      t.string :uf, null: :false
      t.string :naturalidade, null: :false
      t.string :endereco, null: :false
      t.string :telefone, null: :false
      t.string :fax, null: :false
      t.string :email, null: :false

      t.timestamps
    end

    add_index :senadores, :nome, unique: true
  end
end
