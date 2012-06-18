class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, :type => String
  field :body, :type => String
  field :image, :type => String
  #embeds_many :tags
  referenced_in :user
  validates_presence_of [ :title, :body ]

  module ImageMethods
    def image_path
      "#{Rails.root}/public/uploaded/#{self.id.to_s}.png"
    end

    def set_image(image)
      File.open("#{image_path}", 'w').print(image.read.force_encoding('utf-8'))
    end
  end

  include ImageMethods

  def self.create_and_set_image(params)
    # TODO Error Handling
    post = self.new params
    post.save
    post.set_image(params[:image])
    post
  end
end
