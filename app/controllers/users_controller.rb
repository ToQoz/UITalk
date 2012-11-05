# -*- coding: utf-8 -*-

class UsersController < ApplicationController
  respond_to :html, :json

  # allow from login user
  before_filter :authenticate_user!, only: [ :update, :edit ]
  # allow from login user match owner of this page
  before_filter :correct_user?, only: [ :update, :edit ]

  def index
    @users = User.limit 5
    respond_with @users
  end

  def show
    @user = User.name_is(params[:id]).first
    respond_with @user
  end

  # TODO new/create用にnot_authenticate_user!みたいなの必要ありそう.
  def new
    @user = User.new(name: session[:oauth_nickname])
    respond_with @user
  end

  def create
    @user = User.new params[:user]
    @user[:uid] = session[:oauth_uid]
    @user[:provider] = session[:oauth_provider]
    @user.avatar = params[:user][:avatar] if params[:user]
    if @user.save
      session[:user_id] = @user.id
    end
    respond_with @user
  end

  def edit
    @user = User.name_is(params[:id]).first
    respond_with @user
  end

  def update
    @user = User.name_is(params[:id]).first
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :edit
    end
  end

  def followings
    users = User.find_by_name(params[:id])
    users.extend FollowerRole
    @users = users.followings
    render :show_follow
  end

  def followers
    users = User.find_by_name(params[:id])
    users.extend FollowingRole
    @users = users.followers
    render :show_follow
  end

  def follow
    FollowContext.call(current_user, User.find_by_name(params[:id]))
  end

  def unfollow
    UnfollowContext.call(current_user, User.find_by_name(params[:id]))
  end
end
