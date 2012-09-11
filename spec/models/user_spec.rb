# -*- coding: utf-8 -*-

require 'spec_helper'

describe User do
  before :each do
    User.any_instance.stubs(:save_profile_image!)
  end

  # TODO omniauthからの値のテストも必要あり
  describe '.name' do
    it 'は、重複する場合は保存しない。' do
      user1 = FactoryGirl.create(:user, { name: "toqoz" })
      user2 = FactoryGirl.build(:user, { name: "toqoz" })
      user2.should_not be_valid
      user2.should have(1).error_on(:name)
    end
  end

  describe '.password' do
    it 'が、空だと保存失敗する。' do
      user = FactoryGirl.build(:user, { password: "" })
      user.should_not be_valid
      user.should have(1).error_on(:password)
    end
  end

  describe '.email' do
    it 'は、重複する場合は保存しない。' do
      user1 = FactoryGirl.create(:user, { email: "toqoz403@gmail.com" })
      user2 = FactoryGirl.build(:user, { email: "toqoz403@gmail.com" })
      user2.should_not be_valid
      user2.should have(1).error_on(:email)
    end
  end

  describe '.uid' do
    it 'は、.providerが空でない時に、空である場合は保存しない。' do
      user = FactoryGirl.build(:user, { provider: "twitter" })
      user.should_not be_valid
      user.should have(1).error_on(:uid)
    end
    it 'は、.providerが同じ時に、重複する場合は保存しない。' do
      uid = "11111"
      user1 = FactoryGirl.create(:user, { provider: "twitter", uid: uid })
      user2 = FactoryGirl.build(:user, { provider: "twitter", uid: uid })
      user2.should_not be_valid
      user2.should have(1).error_on(:uid)
    end
  end

  describe '.provider' do
    it 'は、.uidが空でない時に、空である場合は保存しない。' do
      user = FactoryGirl.build(:user, { uid: "111111" })
      user.should_not be_valid
      user.should have(1).error_on(:provider)
    end
    it 'は、不正な[User.provider_listに含まれない]値の場合は保存しない。' do
      user = FactoryGirl.build(:user, { provider: "hogetter", uid: "111111" })
      user.should_not be_valid
      user.should have(1).error_on(:provider)
    end
  end

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

  describe '#thirdparty_auth_data_id scope' do
    before :each do
      @user = FactoryGirl.create(:user_with_twitter)
    end
    context '存在するuidとproviderを与えられた場合、' do
      subject { User.thirdparty_auth_data_is(provider: @user.provider, uid: @user.uid) }
      it 'そのユーザーのインスタンスを1件のみ含む。' do
        should include(@user)
        should have(1).items
      end
    end
  end

  describe '#name_is scope' do
    before :each do
      @user = FactoryGirl.build(:user_with_twitter)
      @user.save
    end
    context 'は、空文字列を与えられた場合、' do
      subject { User.name_is('') }
      it 'なにも含まない。' do
        should have(0).items
      end
    end
    context 'は、存在しているユーザー名が与えられた場合、' do
      subject { User.name_is(@user.name) }
      it 'そのユーザーのインスタンスを1件のみ含む。' do
        should include(@user)
        should have(1).items
      end
    end
  end

  describe '#provider_list' do
    subject { User.new.provider_list }
    it { should eq([ 'twitter' ]) }
  end

  describe '#include_by_provider_list' do
    subject { FactoryGirl.build(:user_with_twitter) }
    it { should be_true }
  end

  context '画像の保存に失敗した時、' do
    describe '#save' do
      let (:rails_mock) { mock("Rails") }
      let (:logger_mock) { mock("Rails.logger") }
      let (:user) { FactoryGirl.build(:user) }

      before :all do
        user.stubs(:save_profile_image!).raises
        rails_mock.stubs(:logger).returns(logger_mock)
      end

      it 'は、ロールバックする。' do
        user.save.should eq(nil)
        lambda { User.find(user.id) }.should raise_error(ActiveRecord::RecordNotFound)
      end

      it 'logger#errorが、呼ばれる。' do
        user.save
        rails_mock.logger.expects(:error)
      end
    end
    describe '#save' do
      it 'は、ロールバックする。' do
        user = FactoryGirl.build(:user)
        user.stubs(:save_profile_image!).raises
        lambda { user.save! }.should raise_error(ActiveRecord::RecordNotSaved)
        lambda { User.find(user.id) }.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
