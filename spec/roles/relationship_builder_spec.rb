require 'spec_helper'

describe RelationshipBuilder do
  let(:user) { FactoryGirl.create(:user) }
  let(:target_user) { FactoryGirl.create(:user) }

  before do
    user.extend described_class
  end
  describe '#following?' do
     it { user.should respond_to(:following?) }
  end

  describe '#follow!' do
    it { user.should respond_to(:follow!) }
    context 'when given another user' do
      before do
        user.follow! target_user
      end
      it { user.should be_following(target_user) }
      it 'should not include user in target_user#followers' do
        target_user.followers.should include(user)
      end
    end
  end

  describe '#unfollow!' do
    it { user.should respond_to(:unfollow!) }
    context 'when user succeed to unfollow target user' do
      before do
        user.follow!(target_user)
        user.unfollow!(target_user)
      end
      it { user.should_not be_following(target_user) }
      it 'should include target user in user.followings' do
        user.followings.should_not include(target_user)
      end
    end
  end
end
