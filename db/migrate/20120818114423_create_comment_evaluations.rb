class CreateCommentEvaluations < ActiveRecord::Migration
  def change
    create_table :comment_evaluations do |t|
      t.integer :user_id
      t.integer :comment_id
      t.integer :kind
      t.boolean :available

      t.timestamps
    end
  end
end
