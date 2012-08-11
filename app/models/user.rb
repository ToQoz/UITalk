# -*- coding: utf-8 -*-

# t.string   "provider"
# t.string   "uid"
# t.string   "name"
# t.string   "email"
# t.datetime "created_at",                   :null => false
# t.datetime "updated_at",                   :null => false
# t.string   "image",      :default => ""
# t.boolean  "available",  :default => true
# t.string   "password_digest"

class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password
  attr_accessible :id, :name, :email, :image, :provider, :uid, :password, :password_confirmation, :password_digest

  validate :third_party_oauth_valid?
  validates :uid, :uniqueness => { :case_sensitive => false }
  validates :name, :presence => { :mesage => 'は、必須です' } , :uniqueness => { :case_sensitive => false, :message => 'は、既に登録されています' }
  validates :email, :presence => { :mesage => 'は、必須です' } , :uniqueness => { :case_sensitive => false, :message => 'は、既に登録されています' }

  scope :name_is, lambda { |name| where(["lower(name) = ?", name.downcase]) }
  scope :thirdparty_auth_data_is, lambda { |auth| where(provider: auth[:provider], uid: auth[:uid]) }

  def to_param
    name
  end

  def provider_list
    [ 'twitter' ]
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
private
  def include_by_provider_list?
    provider_list().include? provider
  end

  def third_party_oauth_valid?
    provider_is_empty = (provider.nil? || provider.length < 0)
    uid_is_empty = (uid.nil? || uid.length < 0)

    if !provider_is_empty
      if !include_by_provider_list?
        errors.add(:provider, 'providerが不正')
      elsif uid_is_empty
        errors.add(:uid, 'uidが空です')
      end
    end
    if !uid_is_empty
      errors.add(:provider, 'providerが空です') if provider_is_empty
    end
  end
end
