# -*- coding: utf-8 -*-

class AuthManager
  def initialize(thridparty_auth_data, session)
    @thridparty_auth_data = thridparty_auth_data
    @session = session
  end

  def token
    @thridparty_auth_data["extra"]["access_token"].token
  end

  def secret
    @thridparty_auth_data["extra"]["access_token"].secret
  end

  def authenticate
    # http://rdoc.info/gems/twitter/Twitter/API#verify_credentials-instance_method
    # client.current_user is verify user
    # Twitter::Error::Unauthorized raised when supplied user credentials are not valid.
    begin
      Twitter::Client.new(oauth_token: token, oauth_token_secret: secret).current_user
    rescue
      raise UITalk::NotValidCredential
    end

    unless (user = User.thirdparty_auth_data_is(@thridparty_auth_data).first) == nil
      @session[:user_id] = user.id
      destroy_thridparty_auth_data
      true
    else
      store_thridparty_auth_data @thridparty_auth_data
      false
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
