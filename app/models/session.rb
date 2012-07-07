class Session
  def initialize(session)
    @session = session
  end

  module OAuth
    def store_provider(auth)
      set_oauth({})
      set_oauth_provider auth[:provider]
      set_oauth_uid auth[:uid]
      set_oauth_nickname auth[:info][:nickname]
      set_oauth_image auth[:info][:image]
    end

    def destroy_provider
      set_oauth_provider nil
      set_oauth_uid nil
      set_oauth_nickname nil
      set_oauth_image nil
      set_oauth nil
    end

    def oauth
      @session[:oauth_data]
    end
    def set_oauth(val)
      return nil if @session[:oauth_data]
      @session[:oauth_data] = val
    end
    def oauth(val)
      @session[:oauth_data] = val
    end
    def oauth_uid
      @session[:oauth_data][:uid] if @session[:oauth_data]
    end
    def set_oauth_uid(val)
      @session[:oauth_data][:uid] = val if @session[:oauth_data]
    end
    def oauth_provider
      @session[:oauth_data][:provider] if @session[:oauth_data]
    end
    def set_oauth_provider(val)
      @session[:oauth_data][:provider] = val if @session[:oauth_data]
    end

    def oauth_nickname
      @session[:oauth_data][:nickname] if @session[:oauth_data]
    end
    def set_oauth_nickname(val)
      @session[:oauth_data][:nickname] = val if @session[:oauth_data]
    end

    def oauth_image
      @session[:oauth_data][:image] if @session[:oauth_data]
    end
    def set_oauth_image(val)
      @session[:oauth_data][:image] = val if @session[:oauth_data]
    end
  end

  module User
    def user_id
      @session[:user_id]
    end
    def set_user_id(val)
      @session[:user_id] = val
    end
  end


  include OAuth
  include User
end
