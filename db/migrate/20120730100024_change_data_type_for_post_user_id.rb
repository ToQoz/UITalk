class ChangeDataTypeForPostUserId < ActiveRecord::Migration
  def up
    change_table :posts do |t|
      t.change :user_id, :integer
    end
  end

  def down
    change_table :posts do |t|
      t.change :user_id, :string
    end
  end
end
