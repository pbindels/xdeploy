class Template
  attr_accessor :qdeploy_host, :qdeploy_server
  #@return [Object]
  def template_binding
    binding
  end
end

#         controllers paulbindels master* $ more ../models/template2.rb
#         class Template
#           attr_accessor :all_host_groups
#             # @return [Object]
#               def template_binding
#                   binding
#                     end
#                     end
