class AddLineAddFacebookAddWebsite < ActiveRecord::Migration[7.0]
  def change
    add_column :foundations, :line, :string
    add_column :foundations, :facebook, :string
    add_column :foundations, :website, :string
  end
end
