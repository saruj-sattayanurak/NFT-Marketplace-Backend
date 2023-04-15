ActiveAdmin.register Foundation do
    permit_params :email, :password, :password_confirmation, :name, :description, :location, :wallet_address, :foundation_type, :foundation_members, :telephone_number, :first_image, :second_image, :third_image, :fourth_image, :line, :facebook, :website
  
    index do
      selectable_column
      id_column
      column :name
      column :foundation_type
      column :foundation_members
      column :location
      column :email
      column :wallet_address
      column :line
      column :facebook
      column :website
      actions
    end
  
    filter :email
  
    form do |f|
      f.inputs do
        f.input :email
        f.input :telephone_number
        f.input :password
        f.input :password_confirmation
        f.input :name
        f.input :description
        f.input :foundation_type
        f.input :foundation_members
        f.input :location
        f.input :wallet_address
        f.input :first_image
        f.input :second_image
        f.input :third_image
        f.input :fourth_image
        f.input :line
        f.input :facebook
        f.input :website
      end
      f.actions
    end
  
  end
  