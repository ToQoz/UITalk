class RemoveRoleToProject < ActiveRecord::Migration
  def up
    remove_column :projects, :role
  end

  def down
    add_column :projects, :role, :integer, :default => 1
  end
end
