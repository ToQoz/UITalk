# -*- coding: utf-8 -*-

class PostsController < ApplicationController
  respond_to :html, :json

  def index
    @posts = Post.recent(40)
    @stock = Stock.new
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new(:post_id => @post.id)
  end

  def create
    # TODO 権限管理みたいなことする
    unless user_signed_in?
      redirect_to root_url, notice: 'you should login'
    else
      @post = Post.new({
        title: params[:post][:title],
        body: params[:post][:body],
        user_id: current_user.id,
        image: params["post"]["image"],
        tags_str: params["post"]["tags_str"]
      })
      if @post.save
        redirect_to root_url, notice: 'post complete'
      else
        @posts = Post.recent(40)
        render :template => "posts/index", :locals => {:posts => @posts}
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    check_privilege(@post)
    @post.destroy
    respond_with @post
  end

  def check_privilege(post)
    if !post.editable_by?(post.user_id, current_user)
      raise User::PrivilegeError
    end
  end
end
