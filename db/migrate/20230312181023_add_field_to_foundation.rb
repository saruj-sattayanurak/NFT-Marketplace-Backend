class AddFieldToFoundation < ActiveRecord::Migration[7.0]
  def change
    add_column :foundations, :name, :string
    add_column :foundations, :description, :string
    add_column :foundations, :location, :string
    add_column :foundations, :foundation_members, :integer
    add_column :foundations, :foundation_type, :string
    add_column :foundations, :wallet_address, :string
  end
end
