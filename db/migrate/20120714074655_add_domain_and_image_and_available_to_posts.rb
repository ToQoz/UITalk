class AddDomainAndImageAndAvailableToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :domain, :string, default: ""
    add_column :posts, :image, :string, default: ""
    add_column :posts, :available, :boolean, default: 1
  end
end
