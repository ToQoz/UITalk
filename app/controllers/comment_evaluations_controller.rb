# -*- coding: utf-8 -*-

class CommentEvaluationsController < ApplicationController
  respond_to :html, :json

  # allow from login user
  before_filter :authenticate_user!, only: [ :create, :destroy ]

  def create
    @comment = Comment.find(params[:comment_id])
    @post = Post.find(@comment.post_id)
    @comment_evaluation = CommentEvaluation.new({
      user_id: current_user.id,
      comment_id: params[:comment_id],
      kind: params[:kind]
    })
    if @comment_evaluation.save
      redirect_to @post
    else
      render :template => "posts/show", :locals => {:post => @post, :comment => @comment}
    end
  end
end
