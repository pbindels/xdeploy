class UserMailer < ActionMailer::Base
  default from: "netops@onekingslane.com"

  def status_email(user, login, host, state, project_code, env, artifact)

    env =~ /prod/ ? @notify = Rails.configuration.my_scope.notification_lists["prod1"]
                  : @notify = Rails.configuration.my_scope.notification_lists["non-prod1"]

    @user      = user
    @login     = login
    @host      = host
    @state     = state
    @env       = env
    @project   = project_code
    @artifact  = artifact
    @date      = Time.now

    notifies=@notify.dup
    recipient_list = Array.new
    notifies.push("#{@login}@onekingslane.com")
    recipient_str = Project.find_by(code: project_code).recipients
    recipient_list = recipient_str.split(/,/)    unless recipient_str.nil?
    notifies.push(recipient_list).flatten!.uniq!

    mail(:to => notifies, :subject => "#{@project} -> #{@env},  deployment status: #{state} @#{@date}")
  end

  def delete_email(user, login, host,state, project, env)
    #@log_root = Rails.configuration.my_scope.log_root
    @notify = Rails.configuration.my_scope.notification_list

    @user = user
    @login = login
    @host = host
    @state = state
    @project = project
    @env = env

    notifies=@notify.dup
    notifies.push(@user)

    mail(:to => notifies, :subject => "Deployment Deleted!")
  end
end
