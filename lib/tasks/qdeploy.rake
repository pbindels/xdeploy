namespace :qdeploy do
  
  desc "Load new projects from github"
  task :load_new_projects => :environment do
    Qdeploy::SCM::Github.load_new_projects
  end
end