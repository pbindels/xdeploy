class Environment < ActiveRecord::Base
  has_many :tokens, :as => :tokenable, dependent: :destroy
  
  
  validates_presence_of :name
  validates_uniqueness_of :name, :code, case_sensitive: false
  validates :env_id, presence: true, numericality: {within: 1..99}
end