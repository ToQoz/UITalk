class AddDefaultValueForCommentEvaluationAvailable < ActiveRecord::Migration
  def change
    change_column :comment_evaluations, :available,:boolean,:default => 1
  end
end
