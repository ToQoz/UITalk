class RemoveProfileImageFilenameFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :profile_image_filename
  end

  def down
    add_column :users, :profile_image_filename, :string
  end
end
