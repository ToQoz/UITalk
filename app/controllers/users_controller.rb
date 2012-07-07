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
