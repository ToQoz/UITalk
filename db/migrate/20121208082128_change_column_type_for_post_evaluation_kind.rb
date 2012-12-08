class ChangeColumnTypeForPostEvaluationKind < ActiveRecord::Migration
  def up
    change_table :post_evaluations do |t|
      t.change :kind, :integer
    end
  end

  def down
    change_table :post_evaluations do |t|
      t.change :kind, :string
    end
  end
end
