class AddDefaultValueForPostEvaluationAvailable < ActiveRecord::Migration
  def change
    change_column :post_evaluations, :available, :boolean, :default => 1
  end
end
