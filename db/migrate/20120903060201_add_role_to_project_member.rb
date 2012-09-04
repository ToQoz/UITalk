class AddRoleToProjectMember < ActiveRecord::Migration
  def change
    add_column :project_members, :role, :integer, :default => 1
  end
end
