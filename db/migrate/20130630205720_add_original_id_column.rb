class AddOriginalIdColumn < ActiveRecord::Migration
  def change
    add_column :senadores, :id_original, :integer
  end
end
