# -*- coding: utf-8 -*-

class PostEvaluationsController < ApplicationController
  respond_to :html, :json

  # allow from login user
  before_filter :authenticate_user!, only: [ :create, :destroy ]

  def create
    @post_evaluation = PostEvaluation.new({
      user_id: current_user.id,
      post_id: params[:post_id],
      kind: params[:kind]
    })
    @post_evaluation.save
    respond_with @post_evaluation
  end
end
