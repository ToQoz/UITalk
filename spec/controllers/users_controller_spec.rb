# -*- coding: utf-8 -*-

require 'spec_helper'

describe UsersController do
  before :each do
    User.any_instance.stubs(:save_profile_image!)
  end

  let (:user) { FactoryGirl.build :user }

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
    before :each do
      User.stubs(:limit).returns([ user ])
    end

    it 'は、作成済みのユーザーの配列(Userモデルのインスタンスの配列)を@usersにアサインする。' do
      get :index
      assigns(:users).should eq([ user ])
    end
  end

  describe 'UsersController#show' do
    before :each do
      User.stubs(:name_is).with(user.to_param).returns([ user ])
    end

    it 'は、nameで指定されたUserモデルのインスタンスを@userにアサインする。' do
      get :show, { id: user.to_param }
      assigns(:user).should eq(user)
    end
  end

  describe 'UsersController#new' do
    it 'は、Userモデルにnewメッセージを { name: oauthのニックネーム } というパラメータと一緒に送る。' do
      session[:oauth_nickname] = "ToQoz"
      User.expects(:new).with(name: "ToQoz")

      post :new
      session[:oauth_nickname] = nil
    end
    it 'は、Userモデルのインスタンスを@userにassignする。' do
      post :new
      assigns(:user).should be_a_new(User)
    end
  end

  describe 'UsersController#create' do
    before(:each) { User.stubs new: user }

    it 'は、Userモデルにnewメッセージを送る。' do
      user.expects :save
      post :create
    end

    it 'は、作成されたユーザのページにリダイレクトする。' do
      user.expects :save
      post :create
      response.should redirect_to(user)
    end

    context 'は、User#saveが失敗したとき、' do
      before(:each) { user.stubs(:save).returns(false) }

      it 'ログインできない。(session[:user_id]にuserのidをセットしない。)' do
        post :create
        session[:user_id].should be_nil
      end
    end

    context 'は、User#saveが成功したとき、' do
      before(:each) { user.stubs(:save).returns(true) }

      it 'ログインする。(session[:user_id]にuserのidをセットする)' do
        post :create
        session[:user_id].should eq(user.id)
      end
    end
  end

  describe 'UsersController#update' do
    let (:user) { FactoryGirl.create :user }
    it 'Userモデルにupdate_attributeメッセージを送る' do
      controller.class.skip_before_filter :correct_user?    
      controller.class.skip_before_filter :authenticate_user!

      attr = { "name" => "saint_kenji" }
      User.stubs(:name_is).with(user.to_param).returns([ user ])
      user.expects(:update_attributes).with(attr)
      put :update, :id => user.to_param, :user => attr
    end 
  end
end
