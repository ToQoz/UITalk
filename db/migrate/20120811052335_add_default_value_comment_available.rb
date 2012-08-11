class AddDefaultValueCommentAvailable < ActiveRecord::Migration
  def change
    change_column :comments, :available,:boolean,:default => 1
  end
end
