# -*- coding: utf-8 -*-

require 'spec_helper'

describe PostEvaluation do
  describe '#total' do
    let (:post_evaluation) { FactoryGirl.build(:post_evaluation, { good_count: 3, bad_count: 5 }) }
    it { post_evaluation.total.should eq(-2) }
  end

  describe '#increase_good_count' do
    let (:post_evaluation) { FactoryGirl.build(:post_evaluation, { good_count: 3, bad_count: 5 }) }
    before :all do
      @total = post_evaluation.total
    end
    it { post_evaluation.increase_good_count.total.should eq(@total + 1) }
  end

  describe '#increase_bad_count' do
    let (:post_evaluation) { FactoryGirl.build(:post_evaluation, { good_count: 3, bad_count: 5 }) }
    before :all do
      @total = post_evaluation.total
    end
    it { post_evaluation.increase_bad_count.total.should eq(@total - 1) }
  end
end
