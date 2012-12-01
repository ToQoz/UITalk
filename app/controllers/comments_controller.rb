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
    @comment.save
    respond_with @comment
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.post_id)
    check_privilege(@comment)
    @comment.destroy
    respond_with @comment
  end

  def check_privilege(comment)
    if !comment.editable_by?(comment.user_id, current_user)
      raise User::PrivilegeError
    end
  end
end
