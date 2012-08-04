# -*- coding: utf-8 -*-

require 'spec_helper'

describe Comment do

  let(:post) { FactoryGirl.create(:post) }
  before { @comment = post.comments.build(body: "test") }

  describe ".post_idが存在しない場合はエラー" do
    before { @comment.post_id = nil }
    it { should_not be_valid }
  end

  describe ".bodyが空の場合はエラー" do
    before { @comment.body = "" }
    it { should_not be_valid }
  end

  describe ".bodyが1501文字の場合はエラー" do
    before { @comment.body = "a" * 141 }
    it { should_not be_valid }
  end

end
