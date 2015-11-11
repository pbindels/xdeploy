class ServiceToEnvironment < ActiveRecord::Base
  self.table_name = :service_to_environment

  belongs_to :service
  belongs_to :environment
  
  has_many :tokens, :as => :tokenable


  validates_presence_of :service_id, :environment_id
  validates_uniqueness_of :environment_id, :scope => :service_id
end
 