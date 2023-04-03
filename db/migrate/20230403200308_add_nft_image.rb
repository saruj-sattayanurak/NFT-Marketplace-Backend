class AddNftImage < ActiveRecord::Migration[7.0]
  def change
    add_column :artworks, :url, :string
  end
end
