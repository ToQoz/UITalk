# -*- coding: utf-8 -*-
require 'spec_helper'
# Factory(:post)

describe Post do
  describe 'Validations' do
    it 'require title' do
      should validate_presence_of(:title)
    end
    it 'require body' do
      should validate_presence_of(:body)
    end
  end
  describe 'Post::ImageMethods Module' do
    describe 'ImageMethods#image_path' do
      before do
        @post = FactoryGirl.build(:post)
      end
      it 'return path that "#{Root}/#{path}#{ID}.png"' do
        puts @post.image_path()
        # ??? 内部実装と同じだけど意味あるのか... ???
        @post.image_path().should == "#{Rails.root}/public/uploaded/#{@post.id.to_s}.png"
      end

    end
  end
end
