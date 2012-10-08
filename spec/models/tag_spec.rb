# -*- coding: utf-8 -*-

require 'spec_helper'

describe Tag do
  describe '#name' do
    before do
      @tag = FactoryGirl.build(:tag)
    end
    context 'は、文字列を与えられた場合、' do
      before { @tag.name = "test" }
      it { @tag.name.should eq("test") }
    end
    context 'は、大文字を含んだ文字列を与えられた場合、' do
      before { @tag.name = "Test" }
      it 'は、小文字にする。' do
        @tag.name.should eq("test")
      end
    end
  end

  describe '#normalize' do
    context 'は、大文字を含んだ文字列を与えられた場合、' do
      before { @tag_normalize_str = Tag.normalize("test,Test") }
      it '小文字にする。' do
        @tag_normalize_str.should eq("test,test")
      end
    end
  end

  describe '#to_tag_array' do
    context 'は、カンマ区切りの文字列を与えられた場合、' do
      before { @tag_array = Tag.to_tag_array("test,test2") }
      it '配列にする。' do
        @tag_array.should have(2).items
      end
    end
    context 'は、カンマ区切りの同一文字列を与えられた場合、' do
      before { @tag_array = Tag.to_tag_array("test,test") }
      it 'ユニークの配列にする。' do
        @tag_array.should have(1).items
      end
    end
  end

  describe '#find_or_create_by_name' do
    it 'は、重複する場合は保存しない。' do
      tag1 = FactoryGirl.create(:tag, { name: "wireframe" })
      tag2 = FactoryGirl.build(:tag, { name: "wireframe" })
      tag2.should_not be_valid
      tag2.should have(1).error_on(:name)
    end
  end

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
  end

  describe '#name_is scope' do
    before :each do
      @tag = FactoryGirl.build(:name)
      @tag.save
    end
    context 'は、空文字列を与えられた場合、' do
      subject { Tag.name_is('') }
      it 'なにも含まない。' do
        should have(0).items
      end
    end
    context 'は、存在しているタグ名が与えられた場合、' do
      subject { Tag.name_is(@tag.name) }
      it 'そのタグのインスタンスを1件のみ含む。' do
        should include(@tag)
        should have(1).items
      end
    end
  end
end
