class User
  include Mongoid::Document
  include Mongoid::Timestamps
  #attr_protected :provider, :uid
  field :provider, :type => String
  field :uid, :type => String
  field :name, :type => String
  field :email, :type => String
  references_many :post
  validates_presence_of :provider
  validates_presence_of :uid

  def self.find_by_name(name)
    return nil if name.size <= 0
    self.first(conditions: { name: name })
  end

  def self.optimize_data_from_omniauth_for_fields(auth)
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
