require 'spec_helper'

describe FollowContext do
  let(:follower) { FactoryGirl.create(:user) }
  let(:following) { FactoryGirl.create(:user) }

  it 'follow following for follower' do
    context = described_class.new(follower, following)
    context.follower.expects(:follow!).with(context.following)
    context.call
  end
end
