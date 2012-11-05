# -*- coding: utf-8 -*-

module FollowingRole
  def self.extended(mod)
    mod.class_eval do
      attr_accessor :relationships
    end
    mod.relationships = Relationship.where(following_id: mod.id)
  end

  def followers
    self.relationships.map do |r|
      r.follower
    end
  end
end
