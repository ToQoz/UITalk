require 'spec_helper'

describe UnfollowContext do
  let(:follower) { FactoryGirl.create(:user) }
  let(:following) { FactoryGirl.create(:user) }

  it 'unfollow following for follower' do
    context = described_class.new(follower, following)
    context.follower.expects(:unfollow!).with(context.following)
    context.call
  end
end
