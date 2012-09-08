class AddDefaultValueForTagAvailable < ActiveRecord::Migration
  def change
    change_column :tags, :available, :boolean, :default => 1
  end
end
