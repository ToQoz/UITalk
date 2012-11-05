# -*- coding: utf-8 -*-

class UnfollowContext
  attr_reader :follower, :following

  def self.call(follower, following)
    self.new(follower, following).call
  end

  def initialize(follower, following)
    @follower, @following = follower, following
    @follower.extend FollowerRole
  end

  def call
    @follower.unfollow!(@following)
  end
end
