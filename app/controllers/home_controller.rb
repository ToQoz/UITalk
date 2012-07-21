# -*- coding: utf-8 -*-

class HomeController < ApplicationController
  def index
    @users = User.all
  end
end
