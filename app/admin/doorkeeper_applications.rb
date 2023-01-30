ActiveAdmin.register Doorkeeper::Application do
    menu label: "API Access", priority: 10
    permit_params :name, :uid, :secret, :scopes, :confidential
  
    index do |f|
      selectable_column
      id_column
      column :name
      column :uid
      column :secret
      column :scopes
      actions
    end
  
    filter :name
    filter :scopes
  
    form do |f|
      f.semantic_errors
      f.inputs do
        f.input :name, input_html: {required: true}
        panel "Scopes" do
          "Please input you application scope eg. 'read', 'write', 'read write'"
        end
        f.input :scopes, input_html: {required: true}
      end
      f.actions
    end
  
    show do
      attributes_table do
        row :name
        row :uid
        row :secret
        row :scopes
        row :confidential
        row :created_at
        row :updated_at
      end
      active_admin_comments
    end
  end
  