class Relationship < ActiveRecord::Base

  belongs_to :user

  attr_accessible :follower_id, :following_id
end
