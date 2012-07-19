# -*- coding: utf-8 -*-

class User < ActiveRecord::Base
  has_many :posts

  attr_accessible :id, :name, :email, :image, :provider, :uid

  validates_uniqueness_of :name, :case_sensitive => false

  scope :name_is, lambda { |name| where(["lower(name) = ?", name.downcase]) }
  scope :thirdparty_auth_data_is, lambda { |auth| where(provider: auth[:provider], uid: auth[:uid]) }

  def to_param
    name
  end

  class << self
    # Public: Optimize 3'd party OAuth data that returned by omniauth for User model.
    #
    # auth - A Hash with the 3'rd party OAuth data that returned by omniauth.
    #        :provider  - A String identifying 3'rd party OAuth provider.
    #        :uid  - A String identifying 3'rd party OAuth uid.
    #
    # Examples
    #
    #   optimize_data_from_omniauth_for_fields({
    #     provider: "facebook",
    #     uid: "1111",
    #     info: {
    #       name: "toqoz",
    #       email: "toqoz403@gmail.com"
    #     }
    #   })
    #   # => { provider: "facebook", uid: "1111", name: "toqoz", email: "toqoz403@gmail.com" }
    #
    # Returns a Hash of optimized for User model.
    def optimize_data_from_omniauth_for_fields(auth)
      user = {}
      user[:provider] = auth[:provider]
      user[:uid] = auth[:uid]
      if auth[:info]
        user[:name] = auth[:info][:name] || ""
        user[:email] = auth[:info][:email] || ""
      end
      user
    end
  end
end
