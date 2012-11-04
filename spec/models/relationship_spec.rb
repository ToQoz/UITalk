require 'spec_helper'

describe Relationship do
  before(:each) do
    @follower = FactoryGirl.create(:user)
    @following = FactoryGirl.create(:user)
    @relationship = @following.relationships.build(:following_id => @following.id)
  end
  it "should create a new instance given valid attributes" do
    @relationship.save!
  end

  describe "follow methods" do
    before(:each) do
      @relationship = FactoryGirl.create(:relationship)
    end
    it "should have a follower attribute" do
      @relationship.should respond_to(:follower)
    end
    it "should have the right follower" do
      @relationship.follower.should == @follower
    end
    it "should have a following attribute" do
      @relationship.should respond_to(:following)
    end
    it "should have the right following user" do
      @relationship.following.should == @following
    end
  end

  describe "validations" do
    it "should require a following_id" do
      @relationship.following_id = nil
      @relationship.should_not be_valid
    end
    it "should require a follower_id" do
      @relationship.follower_id = nil
      @relationship.should_not be_valid
    end
  end
end
