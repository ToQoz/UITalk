class CreateProjectMembers < ActiveRecord::Migration
  def change
    create_table :project_members do |t|
      t.integer :user_id
      t.integer :project_id
      t.boolean :available

      t.timestamps
    end
  end
end
