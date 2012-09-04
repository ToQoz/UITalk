class ChangeColumnTypeProjectOwnerId < ActiveRecord::Migration
  def up
    change_table :projects do |t|
      t.change :ower_id, :integer
    end
  end

  def down
    change_table :projects do |t|
      t.change :ower_id, :string
    end
  end
end
