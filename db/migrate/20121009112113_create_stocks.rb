class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :user_id
      t.integer :post_id
      t.boolean :available

      t.timestamps
    end
  end
end
