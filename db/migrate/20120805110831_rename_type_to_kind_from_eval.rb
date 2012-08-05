class RenameTypeToKindFromEval < ActiveRecord::Migration
  def up
    rename_column :evals, :type, :kind
  end

  def down
    rename_column :evals, :kind, :type
  end
end
