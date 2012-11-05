# -*- coding: utf-8 -*-

module FollowerRole
  def following?(follower)
    self.relationships.find_by_following_id(follower.id)
  end
  def follow!(follower)
    self.relationships.create!(:following_id => follower.id)
  end
  def unfollow!(follower)
    self.relationships.find_by_following_id(follower.id).destroy
  end
end
