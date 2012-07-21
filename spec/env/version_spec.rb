# -*- coding: utf-8 -*-

require 'spec_helper'

describe :CheckConfigFiles do
  it {
    RUBY_VERSION.should >= '1.9.3'
  }
  it {
    Rails.version >= '3.2'
  }
end
