class AddImageAndDomainAndAvailableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :image, :string, default: ""
    add_column :users, :domain, :string, default: ""
    add_column :users, :available, :boolean, default: 1
  end
end
