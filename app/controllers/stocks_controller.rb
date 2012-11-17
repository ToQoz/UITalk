# -*- coding: utf-8 -*-

class StocksController < ApplicationController
  respond_to :html, :json

  # allow from login user
  before_filter :authenticate_user!, only: [ :create,  :destroy ]

  def index
    @user = User.find_by_name(params[:user_id])
    if @user
      @stocks = Stock.for_user(@user.id).recent(40)
    else
      #TODO error page
      redirect_to root_url, notice: 'not found user'
    end
  end

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
    @stocks = Stock.for_user(current_user.id).recent(40)
    check_privilege(@stock)
    if @stock.delete
      redirect_to user_stocks_path(:user_id => params[:user_id]), :notice => "Stock deleted"
    else
      render :template => "stocks/index", :locals => {:stocks => @stocks}
    end
  end

  def check_privilege(stock)
    if !stock.editable_by?(current_user.id, stock.user_id)
      raise User::PrivilegeError
    end
  end
end
