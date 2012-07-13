# -*- coding: utf-8 -*-

class AuthManager
  def initialize(thridparty_auth_data, session)
    @thridparty_auth_data = thridparty_auth_data
    @session = session
  end

  def authenticate
    user = User.thirdparty_auth_data_is(@thridparty_auth_data).first
    if user != nil
      @session[:user_id] = user.id
      destroy_thridparty_auth_data
      return true
    else
      store_thridparty_auth_data @thridparty_auth_data
      return false
    end
  end

private
  def destroy_thridparty_auth_data
    @session[:oauth_provider] = nil
    @session[:oauth_uid] = nil
    @session[:oauth_nickname] = nil
    @session[:oauth_image] = nil
  end
  def store_thridparty_auth_data(thridparty_auth_data)
    @session[:oauth_provider] = thridparty_auth_data[:provider]
    @session[:oauth_uid] = thridparty_auth_data[:uid]
    @session[:oauth_nickname] = thridparty_auth_data[:info][:nickname]
    @session[:oauth_image] = thridparty_auth_data[:info][:image]
  end
end
