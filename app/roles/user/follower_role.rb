# -*- coding: utf-8 -*-

module FollowerRole
  def self.extended(base)
    base.class_eval do
      attr_accessor :relationships
    end
    base.relationships = Relationship.where(follower_id: base.id)
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
