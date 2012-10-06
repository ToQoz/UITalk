# -*- coding: utf-8 -*-

class PostsController < ApplicationController
  respond_to :html, :json

  def index
    @posts = Post.recent(40)
  end

  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.build
  end

  def create
    # TODO 権限管理みたいなことする
    unless user_signed_in?
      redirect_to root_url, notice: 'you should login'
    else
      @post = Post.create_and_set_image({
        title: params[:post][:title],
        body: params[:post][:body],
        user_id: current_user.id
      }, params[:post][:image])
      respond_with @post
    end
  end
end
