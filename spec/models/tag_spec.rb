# -*- coding: utf-8 -*-

require 'spec_helper'

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

    context 'が全角の場合はエラー' do
      let(:tag) { FactoryGirl.build(:name_full_width) }
      it { tag.should_not be_valid }
    end

    context "が重複して登録されている場合は登録されない" do
      let(:tag) {
        FactoryGirl.create(:name)
        FactoryGirl.build(:name)
      }
      it { tag.should_not be_valid }
    end

    context "は、存在しているタグ名が与えられた場合、1件含む" do
      let(:tag) { FactoryGirl.create(:name) }
      subject { Tag.name_is(:name) }
      it { should be_true }
    end
  end
end
