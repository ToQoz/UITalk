# -*- coding: utf-8 -*-

require 'spec_helper'

# タグは半角文字で登録されること
# タグは50文字以内？
# 重複したタグは登録されないこと

describe Tag do

  describe '.name' do

    context 'が空の場合はエラー' do
      let(:tag) { FactoryGirl.build(:name_empty) }
      it { tag.should_not be_valid }
    end

    context 'が20文字以内でない場合はエラー' do
      let(:tag) { FactoryGirl.build(:name_max_length) }
      it { tag.should_not be_valid }
    end

    context "が重複して登録されている場合は登録されない" do
      let(:tag) {
        FactoryGirl.create(:name)
        FactoryGirl.build(:name)
      }
      it { tag.should_not be_valid }
    end
  end
end
