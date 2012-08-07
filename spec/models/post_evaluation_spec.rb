# -*- coding: utf-8 -*-

require 'spec_helper'

describe PostEvaluation do
  describe '#total' do
    let (:post_evaluation) { FactoryGirl.build(:post_evaluation, { good_count: 3, bad_count: 5 }) }
    it { post_evaluation.total.should eq(-2) }
  end
end
