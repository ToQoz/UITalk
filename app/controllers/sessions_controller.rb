# TODO sessionからoauthデータとりだすoauth_providerとかoauth_uidみたいなメソッド作る
class SessionsController < ApplicationController
  def new
    redirect_to '/auth/twitter'
  end

  def create
    _session = Session.new session
    auth = request.env["omniauth.auth"]
    user = User.find_by_oauth_data auth
    if user != nil
      # TODO モデルに???
      _session.set_user_id user.id
      _session.destroy_provider
      redirect_to controller: :accounts, action: :login
    else
      _session.store_provider auth
      redirect_to controller: :accounts, action: :signin
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
end
