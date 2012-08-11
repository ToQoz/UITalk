class RenameEvaluationToPostEvaluation < ActiveRecord::Migration
  def up
    rename_table :evaluations, :post_evaluations
  end

  def down
    rename_table :post_evaluations, :evaluations
  end
end
