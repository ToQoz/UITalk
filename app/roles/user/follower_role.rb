# -*- coding: utf-8 -*-

module FollowerRole
  def self.extended(mod)
    mod.class_eval do
      attr_accessor :relationships
    end
    mod.relationships = Relationship.where(follower_id: mod.id)
  end

  def followings
    self.relationships.map do |r|
      r.following
    end
  end
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
