# -*- coding: utf-8 -*-
require 'spec_helper'
# Factory(:post)

describe Post do
  describe 'Validations' do
    it 'titleを必須とする.' do
      should validate_presence_of(:title)
    end
    it 'bodyを必須とする.' do
      should validate_presence_of(:body)
    end
  end
  describe 'Post::ImageMethods' do
    describe '#image_path' do
      before do
        @post = FactoryGirl.build(:post)
      end
      it '絶対パスを返す.' do
        @post.image_path().should == "#{Rails.root}/public/uploaded/#{@post.id.to_s}.png"
      end

    end
  end
end
