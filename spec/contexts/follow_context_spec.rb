require 'spec_helper'

describe FollowContext do
  let(:user) { FactoryGirl.create(:user) }
  let(:target_user) { FactoryGirl.create(:user) }

  it 'follow target user for user' do
    context = described_class.new(user, target_user)
    context.user.expects(:follow!).with(context.target_user)
    context.call
  end
end
