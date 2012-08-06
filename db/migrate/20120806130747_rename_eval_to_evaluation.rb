class RenameEvalToEvaluation < ActiveRecord::Migration
  def up
    rename_table :evals, :evaluations
  end

  def down
    rename_table :evaluations, :evals
  end
end
