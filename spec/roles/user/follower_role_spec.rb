require 'spec_helper'

describe FollowerRole do
  let(:follower) { FactoryGirl.create(:user) }
  let(:following) { FactoryGirl.create(:user) }

  before do
    follower.extend described_class
    following.extend FollowingRole
  end
  describe '#following?' do
    it { follower.should respond_to(:following?) }
  end

  describe '#follow!' do
    it { follower.should respond_to(:follow!) }
    context 'when given another user' do
      before do
        follower.follow! following
      end
      it { follower.should be_following(following) }
      it 'should include follower in following.followers' do
        following.followers.should include(follower)
      end
      it 'should include following in follower.followings' do
        follower.followings.should include(following)
      end
    end
  end

  describe '#unfollow!' do
    it { follower.should respond_to(:unfollow!) }
    context 'when follower succeed to unfollow following' do
      before do
        follower.follow!(following)
        follower.unfollow!(following)
      end
      it { follower.should_not be_following(following) }
      it 'should not include follower in following.followers' do
        follower.followings.should_not include(following)
      end
      it 'should not include following in follower.followings' do
        follower.followings.should_not include(following)
      end
    end
  end
end
