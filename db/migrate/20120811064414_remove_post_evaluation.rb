class RemovePostEvaluation < ActiveRecord::Migration
  def change
    drop_table :post_evaluations
  end
end
