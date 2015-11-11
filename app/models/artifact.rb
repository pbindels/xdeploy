class Artifact < ActiveRecord::Base
  belongs_to :project
  belongs_to :service

  validates :name,      presence: true, uniqueness: true
  validates :file_path, presence: true, uniqueness: true
  
  validates :project_id, presence: true
  validates :service_id, presence: true
end
