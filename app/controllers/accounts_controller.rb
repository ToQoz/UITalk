class AccountsController < ApplicationController
  def signin
    @oauth = {
      provider: session[:oauth_provider],
      uid: session[:oauth_uid]
    }
    @user = User.new(name: session[:oauth_nickname])
  end

  def login
    # TODO 元、[見てた | 見ようとしてた] URLに飛ばす
    redirect_to root_url, :notice => 'Signed in!'
  end
end
