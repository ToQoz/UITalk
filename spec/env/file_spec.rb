# -*- coding: utf-8 -*-

require 'spec_helper'

describe :File do

  Dir.glob("#{Rails.root}/app/**/**/*") { |f|
    it "#{f}に対応するspecが存在する。", :if => /\.rb$/ =~ f do
      filename = f.sub(/#{Rails.root}\/app\//, "#{Rails.root}/spec/").sub(/\.rb$/, '_spec.rb')
      Pathname(filename).should exist
    end

    it "#{f}には、マジックコメントが書かれている。", :if => /\.rb$/ =~ f do
      content = File.open(f).read
      (/^#.*coding: utf-8/i =~ content).should_not be_nil
    end

    it "#{f}には、binding.pryもしくはbinding.remote_pryが含まれていない.", :if => /\.rb$/ =~ f do
      content = File.open(f).read
      (/binding\.(remote_)?pry/i =~ content).should be_nil
    end

    it "#{f}には、console.logもしくはdebuggerが含まれていない.", :if => /\.(js)|(coffee)$/ =~ f do
      content = File.open(f).read
      (/(console\.(log)|(info)|(debug))|(debugger)/i =~ content).should be_nil
    end
  }
end
