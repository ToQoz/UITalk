# -*- coding: utf-8 -*-

require 'spec_helper'

describe Stock do
  let(:stock) { FactoryGirl.build(:stock) }

  describe '.post_id' do
    it 'は、空の場合保存しない' do
      stock.post_id = ""
      stock.should_not be_valid
      stock.should have(1).error_on(:post_id)
    end
    it 'は、重複している場合保存しない' do
      stock1 = FactoryGirl.create(:stock)
      stock2 = FactoryGirl.build(:stock)
      stock2.should_not be_valid
      stock2.should have(1).error_on(:post_id)
    end
  end

  describe '.user_id' do
    it 'は、空の場合保存しない' do
      stock.user_id = ""
      stock.should_not be_valid
      stock.should have(1).error_on(:user_id)
    end
  end

  describe '#recent scope' do
     before do
      @stock1 = FactoryGirl.create(:stock)
      @stock2 = FactoryGirl.create(:stock)
      @stock3 = FactoryGirl.create(:stock)
    end
    context 'は、nを渡すと、' do
      it '新しい順にsortされた投稿をn件含んだ配列を返す' do
        Stock.recent(2).should == [ @stock3, @stock2 ]
      end
    end
  end
end
