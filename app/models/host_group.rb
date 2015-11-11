class HostGroup < ActiveRecord::Base

  has_many :host_to_host_groups
  has_many :hosts, through: :host_to_host_groups
  
  validates :name, presence: true, uniqueness: true

end
