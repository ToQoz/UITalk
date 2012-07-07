class UsersController < ApplicationController

  # allow from login user
  before_filter :authenticate_user!, only: [:update, :edit]
  # allow from login user match owner of this page
  before_filter :correct_user?, only: [:update, :edit]

  def index
    @users = User.all(conditions: {}, limit: 5)
  end

  def show
    @user = User.find_by_slug(params[:id])
    # TODO Not Found User
    redirect_to action: :index if @user == nil
  end

  def create
    _session = Session.new session
    user_data = params[:user]
    user_data[:uid] = _session.oauth_uid
    user_data[:provider] = _session.oauth_provider

    @user = User.new user_data
    @user.save
    _session.set_user_id @user.id
    # TODO リダイレクトではなく, 画面とどまる, ユーザー情報表示
    redirect_to root_url, :notice => 'Posted!'
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
