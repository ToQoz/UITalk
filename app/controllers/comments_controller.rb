# -*- coding: utf-8 -*-

class CommentsController < ApplicationController
  respond_to :html, :json

  # allow from login user
  before_filter :authenticate_user!, only: [ :create, :destroy ]

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

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.post_id)
    check_privilege(@comment)
    if @comment.destroy
      redirect_to @post, notice: 'comment delete complete'
    else
      render :template => "posts/show", :locals => {:post => @post}
    end
  end

  def check_privilege(comment)
    if !comment.editable_by?(current_user.id, comment.user_id)
      raise User::PrivilegeError
    end
  end
end
