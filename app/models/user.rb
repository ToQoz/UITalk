# -*- coding: utf-8 -*-

# t.string   "provider"
# t.string   "uid"
# t.string   "name"
# t.string   "email"
# t.datetime "created_at",                   :null => false
# t.datetime "updated_at",                   :null => false
# t.string   "profile_image_filenameimage",  :default => ""
# t.boolean  "available",  :default => true
# t.string   "password_digest"
# t.string   "uuid"

require 'carrierwave/orm/activerecord'

class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  # Association
  has_many :posts
  has_many :comments
  has_many :stocks

  has_many :project_members
  has_many :projects, through: :project_members

  # Attributes
  has_secure_password
  attr_accessible :uuid, :name, :email, :provider, :uid, :password, :password_confirmation, :password_digest, :avatar

  # Validation
  validate :validate_thirdparty_oauth_data
  validates :name, presence: { mesage: 'は、必須です' }, uniqueness: { case_sensitive: false, message: 'は、既に登録されています' }
  validates :email, presence: { mesage: 'は、必須です' }, uniqueness: { case_sensitive: false, message: 'は、既に登録されています' }

  # Scope
  scope :name_is, lambda { |name| where(["lower(name) = ?", name.downcase]) }
  scope :thirdparty_auth_data_is, lambda { |auth| where(provider: auth[:provider], uid: auth[:uid]) }

  before_save :set_uuid

  def set_uuid
    begin
      self.uuid = generate_uuid
    rescue => e
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")
      false
    end
  end

  # Custom Setter
  def uuid=(value)
    write_attribute(:uuid, value) if uuid.nil?
    raise UITalk::EmptyUUID, "uuid `uuid` is empty" if uuid.to_s == ""
    raise UITalk::NotUniqueUUID, "uuid `uuid` is already exists" if User.where(uuid: uuid).count > 0
  end

  # Custom Setter/Getter
  def generate_uuid
    OpenSSL::Digest::SHA1.hexdigest(UUIDTools::UUID.timestamp_create).downcase
  end

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

  def validate_thirdparty_oauth_data
    provider_is_empty = (provider.nil? || provider.length <= 0)
    uid_is_empty = (uid.nil? || uid.length <= 0)

    return if provider_is_empty && uid_is_empty

    return errors.add(:provider, 'providerが不正') if !include_by_provider_list?
    return errors.add(:provider, 'providerが空です') if provider_is_empty
    return errors.add(:uid, 'uidが空です') if uid_is_empty
    return errors.add(:uid, 'このuidは既に使われています') if User.where(uid: uid).count > 0
  end
end
