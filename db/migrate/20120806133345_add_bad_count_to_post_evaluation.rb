class AddBadCountToPostEvaluation < ActiveRecord::Migration
  def change
    add_column :post_evaluations, :bad_count, :integer
  end
end
