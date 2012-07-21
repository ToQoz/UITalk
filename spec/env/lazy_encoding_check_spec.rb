# -*- coding: utf-8 -*-

require 'spec_helper'

describe :LazyEncodingCheck do

  Dir.glob("#{Rails.root}/app/**/**/*.rb") { |f|
    it "#{f}には、マジックコメントが書かれている。" do
      content = File.open(f).read
      (/^#.*coding: utf-8/i =~ content).should_not be_nil
    end
  }
end
