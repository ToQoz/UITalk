class AddDefaultValueForProjectAvailable < ActiveRecord::Migration
  def change
    change_column :projects, :available, :boolean, :default => 1
  end
end
