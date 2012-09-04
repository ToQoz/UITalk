class AddRoleToProject < ActiveRecord::Migration
  def change
    add_column :projects, :role, :integer, :default => 1
  end
end
