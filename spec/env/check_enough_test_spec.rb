# -*- coding: utf-8 -*-

require 'spec_helper'

describe :CheckEnoughTestSpec do

  Dir.glob("#{Rails.root}/app/**/**/*.rb") { |f|
    it "#{f}に対応するspecが存在する。" do
      File.exist?(f.sub(/#{Rails.root}\/app\//, "#{Rails.root}/spec/").sub(/\.rb$/, '_spec.rb')).should be_true
    end
  }
end
