class AddDefaultValueForProjectOwnerId < ActiveRecord::Migration
  def change
    change_column :projects, :owner_id, :integer, :default => 1
  end
end
