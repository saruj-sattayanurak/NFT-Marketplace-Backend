class RemoveImageUrlAndPrice < ActiveRecord::Migration[7.0]
  def change
    remove_column :artworks, :image_url
    remove_column :artworks, :price
  end
end
