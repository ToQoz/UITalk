# -*- coding: utf-8 -*-

class FollowContext
  attr_reader :user, :target_user

  def self.call(user, target_user)
    self.new(user, target_user).call
  end

  def initialize(user, target_user)
    @user, @target_user = user, target_user
    @user.extend RelationshipBuilder
  end

  def call
    @user.follow!(@target_user)
  end
end
