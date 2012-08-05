class AddDefaultValueForEvalAvailable < ActiveRecord::Migration
  def change
    change_column :evals, :available, :boolean, :default => 1
  end
end
