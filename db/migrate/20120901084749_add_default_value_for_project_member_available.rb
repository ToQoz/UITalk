class AddDefaultValueForProjectMemberAvailable < ActiveRecord::Migration
  def change
    change_column :project_members, :available, :boolean, :default => 1
  end
end
