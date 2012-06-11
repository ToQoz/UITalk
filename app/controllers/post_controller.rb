class PostController < ApplicationController
  before_filter :authenticate_user!, except: [ :index, :show ]
  def index
    @post = Post.all(conditions: {}, limit: 40, sort: [ [ "id", Mongo::DESCENDING ] ])
  end
  def show
    @post = Post.find(params[:id])
  end
  def add
    @post = Post.create_and_set_image(params, current_user)
    redirect_to action: :index
  end
end
