ActiveAdmin.register Employee do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :email
      if f.object.new_record?
          f.input :password
          f.input :password_confirmation
      end
      
      f.input :mobile
      f.input :phone
      f.input :twitter_name
      f.input :facebook_name
      f.input :teams, :as => :check_boxes, :collection => Team.all
    end
    f.buttons
  end
  
  show do |f|
    attributes_table do
      row :name
      row :email
      row :mobile
      row :phone
      row :twitter_name
      row :facebook_name
      row :twitter do 
        link_to image_tag("twitter.png"), f.twitter_url
      end
      row :facebook do 
        link_to image_tag("facebook.png"), f.facebook_url
      end
      row :image do
        image_tag(f.twitter_image(:size => 'original'))
      end
      f.teams.each do |p|
        row :team do 
          p.name
        end
      end
    end
  end
  
  index do
    id_column
    column :name
    column :email
    column :mobile
    column :phone
    column :twitter_image do |f|
      image_tag(f.twitter_image(:size => 'mini'))
    end
    default_actions
  end
  
end
