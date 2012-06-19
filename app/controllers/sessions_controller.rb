class SessionsController < ApplicationController

  def new
    redirect_to '/auth/twitter'
  end

  def create
    auth = request.env["omniauth.auth"]
    # TODO tokenとかのチェックも
    user = User.where(provider: auth[:provider], uid: auth[:uid]).first
    # TODO あとで見直す
    if user != nil
      session[:user_id] = user.id
      destroy_provider_session
      redirect_to controller: :accounts, action: :login
    else
      store_provider_session auth
      redirect_to controller: :accounts, action: :sigin
    end
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

  private
  def store_provider_session(auth)
    session[:provider] = auth[:provider]
    session[:uid] = auth[:uid]
  end

  def destroy_provider_session
    session[:provider] = nil
    session[:uid] = nil
  end

end
