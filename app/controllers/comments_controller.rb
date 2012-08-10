class CommentsController < ApplicationController
  respond_to :html, :json

  # allow from login user
  before_filter :authenticate_user!, only: [ :create ]

  def index
    @comments = Comment.recent(40)
    respond_with @comments
  end

  def show
    @comment = Comment.find(params[:id])
    respond_with @comment
  end

  def create

    @post = Post.find(params[:post_id])

    @comment = Comment.new({
      body: params[:comment][:body],
      user_id: current_user.id,
      post_id: params[:post_id],
    })

    if @comment.save
      redirect_to @post
    else
      render :template => "posts/show", :locals => {:post => @post}
    end
  end

end
