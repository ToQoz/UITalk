class AddDefaultValueForPostsTagsAvailable < ActiveRecord::Migration
  def up
    change_column :posts_tags, :available, :boolean, :default => 1
  end
end
