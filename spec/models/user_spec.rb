# -*- coding: utf-8 -*-

require 'spec_helper'

describe User do
  # TODO omniauthからの値のテストも必要あり
  describe '.optimize_data_from_omniauth_for_fields' do
    context 'は、omniauthからのデータを渡した時、' do
      it '必要なデータを返す。' do
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
  end

  describe '#name_is scope' do
    before :each do
      @user = FactoryGirl.build(:twitter_toqoz)
      @user.save
    end
    context 'は、空文字列を与えられた場合、' do
      it 'なにも含まない。' do
        User.name_is('').should == []
      end
    end
    context 'は、存在しているユーザー名が与えられた場合、' do
      it 'そのユーザーのインスタンスを1件のみ含む。' do
        User.name_is(@user.name).should == [ @user ]
      end
    end
  end
end
