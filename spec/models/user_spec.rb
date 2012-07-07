# -*- coding: utf-8 -*-
require 'spec_helper'
# Factory(:user)

describe User do
  describe 'Validations' do
    it 'uidを必須とする.' do
      should validate_presence_of(:uid)
    end
    it 'providerを必須とする.' do
      should validate_presence_of(:provider)
    end
  end

  describe '#save' do
    context 'すべてのフィールドが与えられた場合' do
      before do
        @user = FactoryGirl.build(:twitter_toqoz)
      end
      it '保存できる.' do
        @user.save.should_not == false
      end
    end
  end

  describe '.optimize_data_from_omniauth_for_fields' do
    it '必要なデータを返す.' do
      omni_auth_data = {
        provider: 'string',
        uid: 'string',
        info: { name: 'string', email: 'string' }
      }
      user = User.optimize_data_from_omniauth_for_fields omni_auth_data
      user.should have_key(:provider)
      user.should have_key(:uid)
    end
  end

  describe '.find_by_name' do
    before :each do
      @user = FactoryGirl.build(:twitter_toqoz)
      @user.save
    end
    context '空文字列を与えられた場合' do
      it 'nilを返す.' do
        User.find_by_name('').should == nil
      end
    end
    context '存在しているユーザー名を与えられた場合' do
      it 'そのユーザーのインスタンスを返す.' do
        User.find_by_name(@user.name).should == @user
      end
    end
  end
end
