class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :set_current_user

  helper_method :current_user
  hide_action :current_user
  before_filter :get_configs
  before_filter :get_auth

  def get_configs
    @qdeploy_hosts          = Hash.new
    @admins                 = Rails.configuration.my_scope.admins
    @locked_projects        = Rails.configuration.my_scope.locked_projects
    @dbrefresh_root         = Rails.configuration.my_scope.dbrefresh_root
    @notification_list      = Rails.configuration.my_scope.notification_list
    @qdeploy_hosts          = Rails.configuration.my_scope.qdeploy_hosts
    @tmp_root               = Rails.configuration.my_scope.tmp_root
    @qdeploy_host           = `hostname`.chomp.gsub(/\.unix\.newokl\.com/,'')
    @nr_api_keys            = Rails.configuration.my_scope.nr_api_keys
    @hb_api_keys            = Rails.configuration.my_scope.hb_api_keys
    @max_display            = Rails.configuration.my_scope.max_display
    @blocked_envs           = Rails.configuration.my_scope.blocked_envs
    #@qdeploy_hosts          = {"prod1" => "sac-prod1-rel-deploy-01", "non-prod1" => "sfo-ops-adm-01"}
    #@king_services=%w(king)
    @king_services=%w(king api_server mobilerouter wordpress)
    @soa_services=%w(payment_service site_configuration_service account_service product_service site_merchandising_service cart_service cerberus_service)
  end

  def get_auth
    if @admins.include?(current_user.username)
      @auth = true
    else
      @auth = false
    end
  end

  def current_user
    @current_user ||= set_current_user
  end

private
  def set_current_user
    username =  if !request.env['HTTP_REMOTE_USER'].blank?
                    request.env['HTTP_REMOTE_USER']
                elsif !request.env['REMOTE_USER'].blank?
                    request.env['REMOTE_USER']
                else
                  nil
                end
    username = "pbindels" if Rails.env.development?
    
    if username.nil?
      render text: :none, :status => :unauthorized
      return
    end
    
    user = User.find_or_create_by!(:username => username)
  end
end
