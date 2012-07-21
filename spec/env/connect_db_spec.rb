# -*- coding: utf-8 -*-

require 'spec_helper'
describe :CheckConfigFiles do
  it { ActiveRecord::Base.connected?.should be_true }
end

