require 'spec_helper'

describe UnfollowContext do
  let(:user) { FactoryGirl.create(:user) }
  let(:target_user) { FactoryGirl.create(:user) }

  it 'unfollow target for user' do
    context = described_class.new(user, target_user)
    context.user.expects(:unfollow!).with(context.target_user)
    context.call
  end
end
