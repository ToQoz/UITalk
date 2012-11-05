# -*- coding: utf-8 -*-

require 'spec_helper'

describe FollowingRole do
  let(:following) { FactoryGirl.create(:user) }
  let(:follower) { FactoryGirl.create(:user) }
  before do
    following.extend FollowingRole
    follower.extend FollowerRole
  end

  describe '#followers' do
    before do
      follower.follow! following
    end
    it { following.followers.should include(follower) }
  end
end
