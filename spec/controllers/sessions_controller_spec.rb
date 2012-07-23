# -*- coding: utf-8 -*-

require 'spec_helper'

describe SessionsController do
  describe :Routing do
    describe "GET /signin" do
      subject { { :get => "/signin" } }
      it { should route_to(controller: "sessions", action: "new") }
    end
    describe "GET /signout" do
      subject { { :get => "/signout" } }
      it { should route_to(controller: "sessions", action: "destroy") }
    end
    describe "GET /auth/:provider/callback" do
      subject { { :get => "/auth/twitter/callback" } }
      it { should route_to(controller: "sessions", action: "create", provider: "twitter") }
    end
    describe "GET /auth/failure" do
      subject { { :get => "/auth/failure" } }
      it { should route_to(controller: "sessions", action: "failure") }
    end
  end
end
