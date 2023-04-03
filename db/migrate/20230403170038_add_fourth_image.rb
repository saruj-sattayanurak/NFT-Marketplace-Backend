class AddFourthImage < ActiveRecord::Migration[7.0]
  def change
    add_column :foundations, :fourth_image, :string
  end
end
