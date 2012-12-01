# -*- coding: utf-8 -*-

require 'spec_helper'

describe Stock do
  before :each do
    User.any_instance.stubs(:save_profile_image!)
  end

  describe 'validate' do
    describe '.post_id' do
      context 'が空の場合' do
        let (:stock) { FactoryGirl.build(:stock, :post_id => nil) }
        it { stock.should_not be_valid }
      end
      context 'が重複して登録された場合' do
        let (:stock) { FactoryGirl.create(:stock) }
        let (:stock2) { FactoryGirl.build(:stock, :post_id => stock.post_id) }
        it { stock2.should_not be_valid }
      end
    end
    describe '.user_id' do
      context 'が空の場合' do
        let (:stock) { FactoryGirl.build(:stock, :user_id => nil) }
        it { stock.should_not be_valid }
      end
    end
  end

  describe '#for_user scope' do
    before do
      @stock = FactoryGirl.create(:stock)
      @stock_o = FactoryGirl.create(:other_user_stock)
    end
    context 'は、user_idを渡すと、' do
      it 'user_idを含んだ配列を返す' do
        Stock.for_user(1).should == [ @stock ]
      end
    end
  end

  describe '#recent scope' do
    before do
      @stock1 = FactoryGirl.create(:stock)
      @stock2 = FactoryGirl.create(:stock)
    end
    context 'は、nを渡すと、' do
      it '新しい順にsortされた投稿をn件含んだ配列を返す' do
        Stock.recent(2).should == [ @stock2, @stock1 ]
      end
    end
  end

  describe "#deletable_by?" do
    context 'は投稿IDとユーザIDが既に存在した場合trueを返す' do
      let(:user) { FactoryGirl.create(:user) }
      let(:post) { FactoryGirl.create(:post, { user_id: user.id }) }
      let(:stock) { FactoryGirl.create(:stock, { user_id: user.id, post_id: post.id }) }
      let(:deletable) { stock.deletable_by?(post.id, user) }
      it { deletable.should be_true }
    end
  end

  describe "#stocked_id_by?" do
    context 'は投稿IDとユーザIDが渡された場合、ストックしたIDを返す' do
      let(:user) { FactoryGirl.create(:user) }
      let(:post) { FactoryGirl.create(:post, { user_id: user.id }) }
      let(:stock) { FactoryGirl.create(:stock, { user_id: user.id, post_id: post.id }) }
      let(:stocked_id) { stock.stocked_id_by?(post.id, user.id) }
      it { stocked_id.should eq(stock.id) }
    end
  end
end
