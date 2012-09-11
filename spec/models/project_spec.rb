# -*- coding: utf-8 -*-

require 'spec_helper'

describe Project do
  before :each do
    User.any_instance.stubs(:save_profile_image!)
  end

  describe '#member scope' do
    let (:project) { FactoryGirl.create(:project) }
    let (:public_project) { FactoryGirl.create(:public_project) }

    it 'は、自分がメンバーになっているプロジェクトを含む。' do
      Project.member(project.users.first).should include(project)
    end
    it 'は、自分がメンバーになっていないパブリックなプロジェクトは含まない。' do
      Project.member(project.users.first).should_not include(public_project)
    end
  end

  describe '#public scope' do
    let (:project) { FactoryGirl.create(:project) }
    let (:public_project) { FactoryGirl.create(:public_project) }

    it 'は、パブリックなプロジェクトを含む。' do
      Project.in_public(project.users.first).should include(public_project)
    end
    it 'は、自分がメンバーになっていてもプライベートのプロジェクトは含まない。' do
      Project.in_public(project.users.first).should_not include(project)
    end
  end

  describe '#visible_for scope' do
    let (:project) { FactoryGirl.create(:project) }
    let (:public_project) { FactoryGirl.create(:public_project) }

    it 'は、自分がメンバーになっているプロジェクトを含む。' do
      Project.visible_for(project.users.first).should include(project)
    end
    it 'は、自分がメンバーになっていなくても、パブリックなプロジェクトは含む。' do
      Project.visible_for(project.users.first).should include(public_project)
    end
  end

  describe '#within_limit? validation' do
    let (:user) { FactoryGirl.create(:user_for_project) }

    it '自分の作成したプライベートプロジェクトが5件より少なければ保存できる。' do
      1.upto(4) { |i| FactoryGirl.create(:project, users: [ user ]) }
      FactoryGirl.build(:project, users: [ user ]).should be_valid
    end
    it '自分の作成したプライベートプロジェクトが5件以上なら保存できない。' do
      1.upto(5) { |i| FactoryGirl.create(:project, users: [ user ]) }
      FactoryGirl.build(:project, users: [ user ]).should_not be_valid
    end
  end
end
