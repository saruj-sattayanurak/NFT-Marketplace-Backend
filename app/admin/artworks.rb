ActiveAdmin.register Artwork do
  actions :all, except: [:edit, :new, :destroy]
end
