class RenameCountToGoodCountFromPostEvaluation < ActiveRecord::Migration
  def up
    rename_column :post_evaluations, :count, :good_count
  end

  def down
    rename_column :post_evaluations, :good_count, :count
  end
end
