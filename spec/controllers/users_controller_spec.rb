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
    it 'は、作成済みのuserを@usersにアサインする。' do
      user = FactoryGirl.create(:user)
      get :index
      assigns(:users).should eq([ user ])
    end
  end

  describe 'UsersController#show' do
    it 'は、nameで指定されたUserモデルのインスタンスを@userにアサインする。' do
      user = FactoryGirl.create(:user)
      get :show, { id: user.name }
      assigns(:user).should eq(user)
    end
  end

  describe 'UsersController#new' do
    it 'は、Userモデルにnewメッセージを { name: oauthのニックネーム } というパラメータと一緒に送る。' do
      session[:oauth_nickname] = "ToQoz"
      User.should_receive(:new).with(name: "ToQoz")
      post :new
      session[:oauth_nickname] = nil
    end
    it 'は、Userモデルのインスタンスを@userにassignする。' do
      post :new
      assigns(:user).should be_a_new(User)
    end
  end

  describe 'UsersController#create' do
    before :each do
      @user = FactoryGirl.create :user
    end
    # TODO context
    it 'は、Userモデルにnewメッセージを送る。' do
      @user.should_receive :save
      User.stub new: @user
      post :create
    end
    it 'は、作成されたユーザのページにリダイレクトする。' do
      @user.should_receive :save
      User.stub new: @user
      post :create
      response.should redirect_to(@user)
    end
    it 'は、User#saveが成功したときsession[:user_id]にuserのidをセットする。つまりログインする。' do
      User.stub new: @user
      User.stub(:save).and_return(true)
      post :create
      session[:user_id].should eq(@user.id)
    end
  end

  describe 'UsersController#update' do
    let (:user) { FactoryGirl.create :user }
    it 'Userモデルにupdate_attributeメッセージを送る' do
      controller.class.skip_before_filter :correct_user?    
      controller.class.skip_before_filter :authenticate_user!

      attr = { "name" => "saint_kenji" }
      User.stub(:name_is).with(user.to_param).and_return([ user ])
      user.should_receive(:update_attributes).with(attr)
      put :update, :id => user.to_param, :user => attr
    end 
  end
end
