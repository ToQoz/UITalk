class FixTypoForProjectOwnerId < ActiveRecord::Migration
  def up
    rename_column :projects, :ower_id, :owner_id
  end

  def down
    # do nothing because this migration is [fix typo]
  end
end
