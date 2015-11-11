class Project < ActiveRecord::Base
  include PublicActivity::Model
  validates :name,        presence: true, uniqueness: true
  validates :code,        presence: true, uniqueness: true

  has_many :tokens, :as => :tokenable, dependent: :destroy

  has_many :services, dependent: :destroy
  has_many :artifacts, dependent: :destroy
  has_many :deployments, dependent: :destroy
  has_many :environments, :through => :services
  has_many :project_users

  has_many :projects_repositories
  has_many :repositories, :through => :projects_repositories
  
  def project_path
    File.join(Rails.configuration.qdeploy.path_prefix, code, 'qdeploy' )
  end
  
  def services_path
    File.join(project_path, 'services' )
  end
  
end
