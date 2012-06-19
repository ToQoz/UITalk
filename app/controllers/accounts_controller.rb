class AccountsController < ApplicationController
  def signin
    @user = { provider: @user[:provider], uid: @user[:uid] }
  end

  def login
    # TODO 元、[見てた | 見ようとしてた] URLに飛ばす
    redirect_to root_url, :notice => 'Signed in!'
  end
end
