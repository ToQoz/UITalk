require 'spec_helper'

describe AccountsController do

  describe "GET 'siginup'" do
    it "returns http success" do
      get 'siginup'
      response.should be_success
    end
  end

  describe "GET 'login'" do
    it "returns http success" do
      get 'login'
      response.should be_success
    end
  end

end
