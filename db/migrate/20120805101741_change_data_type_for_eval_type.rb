class ChangeDataTypeForEvalType < ActiveRecord::Migration
  def up
    change_table :evals do |t|
      t.change :type, :string
    end
  end

  def down
    change_table :evals do |t|
      t.change :type, :integer
    end
  end
end
