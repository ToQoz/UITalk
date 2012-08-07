# -*- coding: utf-8 -*-

class DummyClass
  attr_accessor :good_count, :bad_count

  def initialize(data)
    @good_count = data[:good_count] || 0
    @bad_count = data[:bad_count] || 0
  end
  def countable
    [ 'good_count', 'bad_count' ]
  end
end

require 'spec_helper'

# TODO 例外のテスト等
describe Counter do
  let (:dummy_class) { DummyClass.new(good_count: 1, bad_count: 4) }
  before :all do
    dummy_class.extend(Counter)
    @good_count = dummy_class.good_count
    @bad_count = dummy_class.bad_count
  end
  describe '#increase_good_count' do
    it 'は、DummyClass#good_countを1増加させる' do
      dummy_class.increase_good_count.should eq(@good_count + 1)
    end
  end
  describe '#increase_bad_count' do
    it 'は、DummyClass#bad_countを1増加させる' do
      dummy_class.increase_bad_count.should eq(@bad_count + 1)
    end
  end
end
