class PostsController < ApplicationController
  def index
    @posts = Post.recent(40)
  end

  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.build
  end

  def create
    # TODO 権限管理みたいなことする

    @post = Post.create_and_set_image({
      title: params[:post][:title],
      body: params[:post][:body],
      user_id: current_user.id
    }, params[:post][:image])
    redirect_to action: :index
  end
end
