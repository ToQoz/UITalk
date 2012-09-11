class RenameProfileImageUrlToProfileImageFilenameFromUser < ActiveRecord::Migration
  def up
    rename_column :users, :profile_image_url, :profile_image_filename
  end

  def down
    rename_column :users, :profile_image_filename, :profile_image_url
  end
end
