# TODO sessionからoauthデータとりだすoauth_providerとかoauth_uidみたいなメソッド作る
class SessionsController < ApplicationController
  def new
    redirect_to '/auth/twitter'
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_oauth_data auth
    if user != nil
      # TODO モデルに???
      session[:user_id] = user.id
      destroy_provider
      redirect_to controller: :accounts, action: :login
    else
      store_provider auth
      redirect_to controller: :accounts, action: :signin
    end
  end

  def store_provider(auth)
    session[:oauth_provider] = auth[:provider]
    session[:oauth_uid] = auth[:uid]
    session[:oauth_nickname] = auth[:info][:nickname]
    session[:oauth_image] = auth[:info][:image]
  end

  def destroy_provider
    session[:oauth_provider] = nil
    session[:oauth_uid] = nil
    session[:oauth_nickname] = nil
    session[:oauth_image] = nil
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

  private
end
