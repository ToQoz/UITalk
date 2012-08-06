class CreatePostEvaluations < ActiveRecord::Migration
  def change
    create_table :post_evaluations do |t|
      t.integer :post_id
      t.integer :count
      t.boolean :available

      t.timestamps
    end
  end
end
