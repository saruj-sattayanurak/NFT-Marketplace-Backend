class AddImageAndTelToFoundation < ActiveRecord::Migration[7.0]
  def change
    add_column :foundations, :telephone_number, :string
    add_column :foundations, :first_image, :string
    add_column :foundations, :second_image, :string
    add_column :foundations, :third_image, :string
  end
end
