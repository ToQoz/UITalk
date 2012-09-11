class RenameImageToProfileImageUrlFromUser < ActiveRecord::Migration
  def up
    rename_column :users, :image, :profile_image_url
  end

  def down
    rename_column :users, :profile_image_url, :image
  end
end
