class CreateEvals < ActiveRecord::Migration
  def change
    create_table :evals do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :type
      t.boolean :available

      t.timestamps
    end
  end
end
