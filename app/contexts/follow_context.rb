# -*- coding: utf-8 -*-

class FollowContext
  attr_reader :follower, :following, :followings

  def self.call(follower, following)
    self.new(follower, following).call
  end

  def initialize(follower, following)
    @follower, @following = follower, following
    @follower.extend FollowerRole
  end

  def call
    @follower.follow! @following
  end
end
