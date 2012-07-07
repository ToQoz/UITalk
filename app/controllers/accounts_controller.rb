class AccountsController < ApplicationController
  def signin
    _session = Session.new session
    @oauth_session = {
      provider: _session.oauth_provider,
      uid: _session.oauth_uid
    }
    @user = User.new(name: _session.oauth_nickname)
  end

  def login
    # TODO 元、[見てた | 見ようとしてた] URLに飛ばす
    redirect_to root_url, :notice => 'Signed in!'
  end
end
