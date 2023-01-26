class AddPriceToArtwork < ActiveRecord::Migration[7.0]
  def change
    add_column :artworks, :price, :float
  end
end
