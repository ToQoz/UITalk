# -*- coding: utf-8 -*-

require 'spec_helper'

describe :CheckConfigFiles, :deploy => true do
  it {
    File.exists?("#{Rails.root}/config/initializers/omniauth.rb").should be_true
  }
  it {
    File.exists?("#{Rails.root}/config/initializers/secret_token.rb").should be_true
  }
end
