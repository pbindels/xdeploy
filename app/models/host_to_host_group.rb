class HostToHostGroup < ActiveRecord::Base
  self.table_name = :host_to_host_group
  
  belongs_to :host
  belongs_to :host_group
end
