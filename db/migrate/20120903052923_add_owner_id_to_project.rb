class AddOwnerIdToProject < ActiveRecord::Migration
  def change
    add_column :projects, :ower_id, :string
  end
end

