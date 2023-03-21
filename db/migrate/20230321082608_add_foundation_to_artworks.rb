class AddFoundationToArtworks < ActiveRecord::Migration[7.0]
  def change
    add_reference :artworks, :foundation, null: true, foreign_key: true
  end
end
