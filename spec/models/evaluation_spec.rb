# -*- coding: utf-8 -*-

require 'spec_helper'

describe Evaluation do
  describe '.kind' do
    context 'good評価を登録しようとした時、' do
      let(:eval) { FactoryGirl.build(:good_kind_eval) }
      it {
        eval.kind.should eq("1")
        eval.should be_valid
      }
    end
    context 'bad評価を登録しようとした時、' do
      let(:eval) { FactoryGirl.build(:bad_kind_eval) }
      it {
        eval.kind.should eq("2")
        eval.should be_valid
      }
    end
    context 'goog/badでもない評価を登録しようとした時、' do
      let (:eval) { FactoryGirl.build(:invalid_kind_eval) }
      it {
        eval.should_not be_valid
        eval.should have(1).errors_on(:kind)
      }
    end
  end

  describe '#kind_list' do
    subject { Evaluation.new.kind_list }
    it { should eq([ "1", "2"]) }
  end

  describe 'name_scope' do
    let (:good) { FactoryGirl.build(:good_kind_eval) }
    let (:bad) { FactoryGirl.build(:bad_kind_eval) }

    before :each do
      good.save
      bad.save
    end

    describe '#default_scopeは有効なレコードのみを含む。' do
      subject { Evaluation.all }
      it {
        should include(good)
        should include(bad)
      }
      it {
        #bad.update_attributes(available: 0)
        #should_not include(good)
      }
    end

    describe '#goodは、goodと評価されたものだけを含む。' do
      subject { Evaluation.good }
      it {
        should include(good)
        should_not include(bad)
      }
    end

    describe '#badは、badと評価されたものだけを含む。' do
      subject { Evaluation.bad }
      it {
        should include(bad)
        should_not include(good)
      }
    end
  end
end
