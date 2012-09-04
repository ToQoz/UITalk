# -*- coding: utf-8 -*-

# t.integer  "user_id"
# t.integer  "project_id"
# t.integer  "role"      default => 1 (1: read, 2:readwrite)
# t.boolean  "available"

class ProjectMember < ActiveRecord::Base
  attr_accessible :available, :project_id, :user_id, :role
  belongs_to :user
  belongs_to :project
end
