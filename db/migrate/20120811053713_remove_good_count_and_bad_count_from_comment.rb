class RemoveGoodCountAndBadCountFromComment < ActiveRecord::Migration
  def up
    remove_column :comments, :good_count
    remove_column :comments, :bad_count
  end

  def down
  end
end
