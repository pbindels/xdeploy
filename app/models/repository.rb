class Repository < ActiveRecord::Base
  has_many :projects_repositories
  has_many :projects, :through => :projects_repositories
  
end
