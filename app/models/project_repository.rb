class ProjectRepository < ActiveRecord::Base
  belongs_to :project_id
  belongs_to :repository_id
end
