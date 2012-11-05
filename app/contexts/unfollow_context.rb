# -*- coding: utf-8 -*-

class UnfollowContext
  attr_reader :user, :target_user

  def self.call(user, target_user)
    self.new(user, target_user).call
  end

  def initialize(user, target_user)
    @user, @target_user = user, target_user
    @user.extend FollowerRole
  end

  def call
    @user.unfollow!(@target_user)
  end
end
