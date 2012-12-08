# -*- coding: utf-8 -*-

require 'spec_helper'

describe Post do
  describe '#recent scope' do
     before do
      @post1 = FactoryGirl.build(:post_1)
      @post1.save
      @post2 = FactoryGirl.build(:post_2)
      @post2.save
      @post3 = FactoryGirl.build(:post_1)
      @post3.save
    end
    context 'は、nを渡すと、' do
      it '新しい順にsortされた投稿をn件含んだ配列を返す' do
        Post.recent(2).should == [ @post3, @post2 ]
      end
    end
  end
  describe '#image_path' do
    before do
      @post = FactoryGirl.build(:post)
    end
    context 'は、存在する相対パスを渡した場合、' do
      it 'その絶対パスを返す。' do
        @post.image_path().should == "#{Rails.root}/public/uploaded/#{@post.id.to_s}.png"
      end
    end
  end

  describe '.title' do
    before do
      @post = FactoryGirl.build(:post)
    end
    context "が未入力の場合はエラー" do
      before { @post.title="" }
      it { should_not be_valid }
    end
    context "が150文字以上の場合はエラー" do
      before { @post.title="a" * 151 }
      it { should_not be_valid }
    end
  end

  describe '.body' do
    before do
      @post = FactoryGirl.build(:post)
    end
    context "が未入力の場合はエラー" do
      before { @post.body="" }
      it { should_not be_valid }
    end
    context "が150文字以上の場合はエラー" do
      before { @post.body="a" * 1501 }
      it { should_not be_valid }
    end
  end

  describe "#editable_by?" do
    context '投稿したユーザIDとユーザIDが等しい場合' do
      let(:user) { FactoryGirl.create(:user) }
      let(:post) { FactoryGirl.create(:post, { user_id: user.id }) }
      let(:editable) { post.editable_by?(post.user_id, user) }
      it { editable.should be_true }
    end
  end
end
