# -*- coding: utf-8 -*-

module FollowingRole
  def self.extended(base)
    base.class_eval do
      attr_accessor :relationships
    end
    base.relationships = Relationship.where(following_id: base.id)
  end

  def followers
    self.relationships.map do |r|
      r.follower
    end
  end
end
