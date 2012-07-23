# -*- coding: utf-8 -*-

require 'spec_helper'

describe UsersController do
  describe :Routing do
    describe "GET /users" do
      subject { { :get => "/users" } }
      it { should route_to(controller: "users", action: "index") }
    end
    describe "GET /users/:id" do
      subject { { :get => "/users/ToQoz" } }
      it { should route_to(controller: "users", action: "show", id: "ToQoz") }
    end

    describe "POST /accounts/signup" do
      subject { { :post => "/accounts/signup" } }
      it { should route_to(controller: "users", action: "create") }
    end

    describe "GET /accounts/signup" do
      subject { { :get => "/accounts/signup" } }
      it { should route_to(controller: "users", action: "new") }
    end
  end
  describe 'UsersController#index' do
    it '作成済みのuserが@usersにアサインされている。' do
      user = FactoryGirl.create(:user)
      get :index
      assigns(:users).should eq([ user ])
    end
  end
  describe 'UsersController#show' do
    it 'nameで指定されたユーザのインスタンスが@userにアサインされている。' do
      user = FactoryGirl.create(:user)
      get :show, { id: user.name }
      assigns(:user).should eq(user)
    end
  end
  describe 'UsersController#create' do
    before :each do
      @user = FactoryGirl.create :user
    end
    it 'Userモデルはsaveメソッドを呼び出しのメッセージを受け取る。' do
      @user.should_receive :save
      User.stub new: @user
      post :create
    end
    it '作成されたユーザのページにリダイレクトされる。' do
      @user.should_receive :save
      User.stub new: @user
      post :create
      response.should redirect_to(@user)
    end
  end
end
