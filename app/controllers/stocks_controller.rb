# -*- coding: utf-8 -*-

class CommentsController < ApplicationController
  respond_to :html, :json

  # allow from login user
  before_filter :authenticate_user!, only: [ :create, :destroy ]

  def create
    @stock = Stock.new({
      user_id: current_user.id,
      post_id: params[:post_id],
    })
    @stock.save
    respond_with @stock
  end

  def destroy
    @stock = Stock.find(params[:id])
    #TODO権限管理
    @stock.destroy
    respond_with @stock
  end
end
