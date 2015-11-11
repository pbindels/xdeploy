class Service < ActiveRecord::Base
  include PublicActivity::Model
  belongs_to :project
  
  has_many :tokens, :as => :tokenable, dependent: :destroy
  has_many :service_to_environments, dependent: :destroy
  has_many :environments, :through => :service_to_environments
  
  has_many :artifacts, dependent: :destroy
  

  validates :code, presence: true, uniqueness:  { message: "Service code already in use!"}
  validates :name, presence: true

  def lock_file(env)
    File.join(Rails.configuration.qdeploy.path_prefix, project.code, 'qdeploy', 'tmp', "#{self.code}.#{env}.lock" )
  end
  
  def locked?(env)
    File.exists?(lock_file(env))
  end
  
  def service_path
    File.join(project.project_path, code)
  end
  
  def deployment_logs_path
    File.join(service_path, 'var')
  end
  
end