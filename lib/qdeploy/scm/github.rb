require 'github_api'

module Qdeploy
  module SCM
    class Github
      
      def initialize
        @github = ::Github.new client_id: Rails.configuration.qdeploy.github.client_id,
                               client_secret: Rails.configuration.qdeploy.github.client_secret,
                               login: Rails.configuration.qdeploy.github.username,
                               password: Rails.configuration.qdeploy.github.password
      end
      
      def repos
        @github.repos.list :org => Rails.configuration.qdeploy.github.org
      end
      
      class << self
        def load_new_projects
          instance = self.new
          repos = instance.repos

          repos.each do |repo|

            local_repo = if GithubRepository.where(:uuid => repo.id.to_s).exists?
                           GithubRepository.where(:uuid => repo.id.to_s).first
                         else
                           GithubRepository.new(:uuid => repo.id.to_s)
                         end
            
            local_repo.name = repo.name
            local_repo.url = repo.url
            local_repo.description = repo.description
            
            local_repo.save!
          end
        end
      end
    end
  end
end