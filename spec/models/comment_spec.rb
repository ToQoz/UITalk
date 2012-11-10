# -*- coding: utf-8 -*-

require 'spec_helper'

describe Comment do

  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, { user_id: user.id }) }
  let(:comment) { FactoryGirl.build(:comment, { user_id: user.id, post_id: post.id }) }

  describe ".post_idが存在しない場合はエラー" do
    before { comment.post_id = nil }
    it { should_not be_valid }
  end

  describe ".bodyが空の場合はエラー" do
    before { comment.body = "" }
    it { should_not be_valid }
  end

  describe ".bodyが1501文字の場合はエラー" do
    before { comment.body = "a" * 141 }
    it { should_not be_valid }
  end

  describe "#created_name" do
    context 'は、ユーザIDが渡された場合、' do
      before { @created_name = comment.created_name(comment.user_id) }
      it 'そのユーザの名前を返す。' do
        @created_name.should eq(user.name)
      end
    end
  end

  describe "#editable_by?" do
    context 'は、コメントしたユーザIDとログインしたユーザIDが渡された場合、' do
      before { @editable = comment.editable_by?(comment.user_id, user.id) }
      it '等しい場合、trueを返す' do
        @editable.should be_true
      end
    end
  end
end
