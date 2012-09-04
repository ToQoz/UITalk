# -*- coding: utf-8 -*-

# t.string   "name"
# t.string   "description"
# t.boolean  "available"
# t.boolean  "is_publiec"

class Project < ActiveRecord::Base
  attr_accessible :available, :description, :is_public, :name, :owner_id

  has_many :project_members
  has_many :users, :through => :project_members

  validate :within_limit?

  default_scope where(available: true)
  scope :in_public, where(is_public: true)
  scope :in_private, where(is_public: false)
  scope :member, lambda { |user| where("users.id = ?", user.id).joins(:users) }
  scope :owner, lambda { |owner_id| where(owner_id: owner_id) }
  scope :visible_for, lambda { |user| where("users.id = ? OR is_public = ?", user.id, true).includes(:users) }

  private

  def within_limit?
    if Project.in_private.owner(owner_id).count >= 5
      errors[:base] << 'プライベートプロジェクトの上限を超えています'
    end
  end
end
