# -*- coding: utf-8 -*-

require 'spec_helper'

describe Post do
  describe 'Post::ImageMethods' do
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
  end
end
