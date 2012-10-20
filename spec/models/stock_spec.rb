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
end
