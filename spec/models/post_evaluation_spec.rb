# -*- coding: utf-8 -*-

require 'spec_helper'

describe PostEvaluation do
  before :each do
    User.any_instance.stubs(:save_profile_image!)
  end

  describe '.kind' do
    context 'good評価を登録しようとした時、' do
      let(:eval) { FactoryGirl.build(:good_kind_post_eval) }
      it {
        eval.kind.should eq(1)
        eval.should be_valid
      }
    end
    context 'bad評価を登録しようとした時、' do
      let(:eval) { FactoryGirl.build(:bad_kind_post_eval) }
      it {
        eval.kind.should eq(2)
        eval.should be_valid
      }
    end
    context 'goog/badでもない評価を登録しようとした時、' do
      let (:eval) { FactoryGirl.build(:invalid_kind_post_eval) }
      it {
        eval.should_not be_valid
        eval.should have(1).errors_on(:kind)
      }
    end
  end

  describe '#kind_list' do
    subject { PostEvaluation.new.kind_list }
    it { should eq([ 1, 2]) }
  end

  describe 'name_scope' do
    let (:good) { FactoryGirl.build(:good_kind_post_eval) }
    let (:bad) { FactoryGirl.build(:bad_kind_post_eval) }

    before :each do
      good.save
      bad.save
    end

    describe '#default_scopeは有効なレコードのみを含む。' do
      subject { PostEvaluation.all }
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
      subject { PostEvaluation.good }
      it {
        should include(good)
        should_not include(bad)
      }
    end

    describe '#badは、badと評価されたものだけを含む。' do
      subject { PostEvaluation.bad }
      it {
        should include(bad)
        should_not include(good)
      }
    end
  end

  describe 'validate' do
    describe '.user_id' do
      context '重複して評価しようとした時、' do
        let (:eval) { FactoryGirl.create(:good_kind_post_eval) }
        let (:eval2) { FactoryGirl.build(:good_kind_post_eval, { :user_id => eval.user_id , :post_id => eval.post_id}) }
        it { eval2.should_not be_valid }
      end
    end
  end

  describe '#evaluable_by?' do
    context '投稿IDとユーザIDのデータが存在する場合' do
      let (:eval) { FactoryGirl.create(:good_kind_post_eval) }
      let (:evaluable) { eval.evaluable_by?(eval.post_id, eval.user_id) }
      it { evaluable.should be_false }
    end
  end
end
