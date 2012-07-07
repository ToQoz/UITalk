class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  #attr_protected :provider, :uid
  field :provider, :type => String
  field :uid, :type => String
  field :name, :type => String
  field :email, :type => String
  references_many :post
  validates_presence_of :provider
  validates_presence_of :uid
  slug :name

  # For ActiveRecord. When you use Mogoid, you should use mongoid-slug.
  # def to_param
  #   name
  # end

  class << self
    def find_by_name(name)
      self.where(:name => name).first
    end

    def find_by_oauth_data(auth)
      self.where(provider: auth[:provider], uid: auth[:uid]).first
    end

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
