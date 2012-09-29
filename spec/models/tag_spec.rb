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
