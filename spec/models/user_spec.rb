# -*- coding: utf-8 -*-
require 'spec_helper'
# Factory(:user)

describe User do
  describe 'Validations' do
    it 'require uid' do
      should validate_presence_of(:uid)
    end
    it 'require provider' do
      should validate_presence_of(:provider)
    end
  end

  context 'when given full feed' do
    before do
      @user = FactoryGirl.build(:twitter_toqoz)
    end
    it 'succeeds save' do
      @user.save.should_not == false
    end
  end

  context 'when given a omniauthdata' do
    before do
      @omni_auth_data = {
        provider: 'string',
        uid: 'string',
        info: {
          name: 'string',
          email: 'string'
        }
      }
    end

    describe 'User.optimize_data_from_omniauth_for_fields' do
      before do
        @userdata = User.optimize_data_from_omniauth_for_fields @omni_auth_data
      end

      context 'when get data form User#optimize_data_from_omniauth_for_fields' do
        describe 'User#create!' do
          it 'succeeds create' do
            proc { User.create! @userdata }.should_not raise_error
          end
        end
      end
    end
  end

  describe 'User.find_by_name' do
    context 'when given a empty string for user\'s name ' do
      it 'return nil' do
        User.find_by_name('').should == nil
      end
    end
    context 'when given a user\'s name that is exists' do
      before do
        @user = FactoryGirl.build(:twitter_toqoz)
        @user.save
      end

      it 'return this user' do
        User.find_by_name(@user.name).should == @user
      end
    end
  end
end
