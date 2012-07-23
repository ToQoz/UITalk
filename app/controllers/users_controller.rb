# -*- coding: utf-8 -*-

class UsersController < ApplicationController
  # TODO ApplicationControllerに実装
  # allow from login user
  before_filter :authenticate_user!, only: [:update, :edit]
  # allow from login user match owner of this page
  before_filter :correct_user?, only: [:update, :edit]

  def index
    @user = User.new(name: session[:oauth_nickname])
  end

  def show
    @user = User.name_is(params[:id]).first
    redirect_to action: :index if @user == nil
  end

  def new
    @user = User.new(name: session[:oauth_nickname])
  end

  def create
    @user = User.new params[:user]
    @user[:uid] = session[:oauth_uid]
    @user[:provider] = session[:oauth_provider]
    if @user.save
      session[:user_id] = @user.id
    end
    render :new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :edit
    end
  end
end
