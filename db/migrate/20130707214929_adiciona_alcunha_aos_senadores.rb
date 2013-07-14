class AdicionaAlcunhaAosSenadores < ActiveRecord::Migration
  def change
    add_column :senadores, :alcunha, :string
  end
end
