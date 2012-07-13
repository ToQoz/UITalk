# -*- coding: utf-8 -*-

class SessionsController < ApplicationController
  def new
    redirect_to '/auth/twitter'
  end

  def create
    authManager = AuthManager.new request.env["omniauth.auth"], session
    if authManager.authenticate
      redirect_to root_url, notice: 'Signed in!'
    else
      redirect_to controller: :accounts, action: :signup
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'Signed out!'
  end

  def failure
    redirect_to root_url, alert: "Authentication error: #{params[:message].humanize}"
  end

private
end
