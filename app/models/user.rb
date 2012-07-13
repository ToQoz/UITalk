# -*- coding: utf-8 -*-

class User < ActiveRecord::Base
  attr_accessible :id, :email, :name, :provider, :uid

  validates_uniqueness_of :name, :case_sensitive => false

  scope :name_is, lambda { |name| where(["lower(name) = ?", name.downcase]) }
  scope :thirdparty_auth_data_is, lambda { |auth| where(provider: auth[:provider], uid: auth[:uid]) }

  def to_param
    name
  end

  class << self
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
