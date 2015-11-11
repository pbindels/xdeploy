# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.active_leaf_class = 'active'
 
  Rails.logger.info "#{@qdeploy_host} is host"
  Rails.logger.info "#{@qdeploy_hosts["non-prod1"]} is non prod"
  navigation.items do |primary|
    primary.item :projects_item, 'Projects', projects_path, icon: ['icon-folder-open']
    primary.item :environments_item, 'Environments', environments_path, icon: ['icon-globe']
    #primary.item :tokens_item, 'Tokens', tokens_path, icon: ['icon-wrench']
    primary.item :deployment_link, 
                 'Deploy!', 
                 new_deployment_path(format: :js),
                 :icon => ['icon-cloud-upload'], 
                 :link => {"data-content-url" => new_deployment_path, "data-title" => "Deployment", 'data-modal-id' => 'deployment-modal'}
    primary.item :token_item, "Tokens", tokens_path, icon: ['icon-key']
    primary.item :stats_item, "Environment Status", status_path ,icon: ['icon-info-sign']
    primary.item :proj_stats_item, "Project Status", project_env_status_path ,icon: ['icon-info-sign']
    primary.item :dbrefresh_item, "DB Refresh", dbrefresh_path, icon: ['icon-refresh']   if @qdeploy_host =~ /#{@qdeploy_hosts["non-prod1"]}/
    primary.item :soarefresh_item, "SOA Refresh", soarefresh_path, icon: ['icon-refresh']   if @qdeploy_host =~ /#{@qdeploy_hosts["non-prod1"]}/
    primary.item :bulkrefresh_item, "Bulk Refresh", bulkrefresh_path, icon: ['icon-refresh']   if @qdeploy_host =~ /#{@qdeploy_hosts["non-prod1"]}/
    primary.item :dbrefresh_item, "Deployment Stats", deploy_stats_path, icon: ['icon-signal']
    primary.item :user_item, "User Manager", users_path, icon: ['icon-user'] if @auth
    primary.dom_class = 'nav nav-list well'
    primary.auto_highlight = true
  end
end
