# -*- coding: utf-8 -*-

require 'spec_helper'

describe :CheckConfigFiles, :deploy => true do
  it 'config/initializers/twitter.rbが存在している' do
    File.exists?("#{Rails.root}/config/initializers/twitter.rb").should be_true
  end
  it 'config/initializers/omniauth.rbが存在している' do
    File.exists?("#{Rails.root}/config/initializers/omniauth.rb").should be_true
  end
  it 'config/initializers/secret_token.rbが存在している' do
    File.exists?("#{Rails.root}/config/initializers/secret_token.rb").should be_true
  end
end
