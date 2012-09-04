class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.boolean :is_public
      t.boolean :available

      t.timestamps
    end
  end
end
