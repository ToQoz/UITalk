class RemoveDomainFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :domain
  end

  def down
    add_column :users, :domain, :string
  end
end
