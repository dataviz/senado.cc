class AddSlugToSenador < ActiveRecord::Migration
  def change
    add_column :senadores, :slug, :string
  end
end
