class CommentsController < ApplicationController
  def index
    @comments = Comment.recent(40)
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create

    # TODO 権限管理みたいなことする
    @comment = Comment.create({
      body: params[:comment][:body],
      user_id: current_user.id,
      post_id: params[:post_id],
    })
    redirect_to :back
  end

end
