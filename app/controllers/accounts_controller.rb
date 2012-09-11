# -*- coding: utf-8 -*-

class AccountsController < ApplicationController
  def signup
    @user = User.new(name: session[:oauth_nickname])
  end
  def setting
    @user = current_user
  end
end
