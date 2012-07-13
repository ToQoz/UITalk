# -*- coding: utf-8 -*-

class AccountsController < ApplicationController
  def signup
    @oauth = {
      provider: session[:oauth_provider],
      uid: session[:oauth_uid]
    }
    @user = User.new(name: session[:oauth_nickname])
  end
end
