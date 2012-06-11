class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, :type => String
  field :body, :type => String
  field :image, :type => String
  #embeds_many :tags
  referenced_in :user
  validates_presence_of [ :title, :body ]

  def self.create_and_set_image(params, current_user)
    post = self.where(
      title: params[:title], body: params[:body], image: params[:image],
      user: current_user
    ).create
    if post
      self.set(post.id.to_s, params[:image].read.force_encoding('utf-8'))
      post
    else
      # TODO
      nil
    end
  end
  def self.set(name, image)
    # TODO Error Handling
    path = "#{Rails.root}/public/uploaded/#{name}.png"
    # set /public/uploaded/xxx.png
    File.open("#{path}", 'w').print(image)
  end
end
