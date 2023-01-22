class CreateArtworks < ActiveRecord::Migration[7.0]
  def change
    create_table :artworks do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.integer :status

      t.timestamps
    end
  end
end
