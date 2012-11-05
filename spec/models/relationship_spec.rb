# -*- coding: utf-8 -*-

require 'spec_helper'

describe Relationship do
  before(:each) do
    @following = FactoryGirl.create(:following)
    @follower = FactoryGirl.create(:follower)
    @relationship = FactoryGirl.build(:relationship, { following_id: @following.id, follower_id: @follower.id })
  end
  it "should create a new instance given valid attributes" do
    @relationship.save!
  end

  describe "follower" do
    it "should have a follower attribute" do
      @relationship.should respond_to(:follower)
    end
    it "should have the right follower" do
      @relationship.follower.should == @follower
    end
  end

  describe "following" do
    it "should have a following attribute" do
      @relationship.should respond_to(:following)
    end
    it "should have the right following user" do
      @relationship.following.should == @following

    end
  end

  describe ".following_id" do
    it "should require a following_id" do
      @relationship.following_id = nil
      @relationship.should_not be_valid
    end
  end

  describe ".follower_id" do
    it "should require a follower_id" do
      @relationship.follower_id = nil
      @relationship.should_not be_valid
    end
  end
end
