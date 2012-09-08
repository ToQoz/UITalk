# -*- coding: utf-8 -*-

class SessionsController < ApplicationController
  def new
    redirect_to '/auth/twitter'
  end

  def create
    authManager = AuthManager.new request.env["omniauth.auth"], session

    begin
      if authManager.authenticate
        redirect_to root_url, notice: 'Signed in!'
      else
        redirect_to controller: :users, action: :new
      end
    rescue UITalk::NotValidCredential
      redirect_to root_url, alert: 'User credentials are not valid'
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
