class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.integer :user_id
      t.string :body
      t.boolean :available

      t.timestamps
    end
  end
end
