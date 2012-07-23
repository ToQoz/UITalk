# -*- coding: utf-8 -*-

require 'spec_helper'

describe UsersController do
  describe :Routing do
    describe "GET 'index'" do
      subject { { :get => "/users" } }
      it { should route_to(controller: "users", action: "index") }
    end
    describe "GET /usres/:id" do
      subject { { :get => "/users/ToQoz" } }
      it { should route_to(controller: "users", action: "show", id: "ToQoz") }
    end

    describe "POST /accounts/signup" do
      subject { { :post => "/accounts/signup" } }
      it { should route_to(controller: "users", action: "create") }
    end

    describe "GET /accounts/signup" do
      subject { { :get => "/accounts/signup" } }
      it { should route_to(controller: "users", action: "new") }
    end
  end
end
