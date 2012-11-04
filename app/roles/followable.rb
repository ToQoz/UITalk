# -*- coding: utf-8 -*-

module Followable
  def following?(target)
    self.relationships.find_by_following_id(target.id)
  end
  def follow!(target)
    self.relationships.create!(:following_id => target.id)
  end
  def unfollow!(target)
    self.relationships.find_by_following_id(target.id).destroy
  end
end
