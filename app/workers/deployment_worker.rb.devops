require 'net/ssh'
class DeploymentWorker
  include Sidekiq::Worker
  
  #sidekiq_options queue: :deployment

  def perform(deployment_id)
    deployment  = Deployment.find(deployment_id)
    environment = deployment.environment
    user        = deployment.user
    artifact    = deployment.artifact
    project     = deployment.project
    service     = deployment.service
    hostfile    = deployment.web_only ? "web_hosts_only" : "hosts"

    Rails.logger.info "Deployment hostfile is #{hostfile}"

    deployment.update_column(:started_at, Time.now)
    Net::SSH.start(Rails.configuration.qdeploy.deployer.host, Rails.configuration.qdeploy.deployer.user) do |ssh|
      channel = ssh.open_channel do |ch|

        script =<<-EOS
          cd /opt/qdeploy/1.4.0 && ./bin/dccontrol                  \
          -a install                                                \
          -c /okl/#{project.code}/qdeploy/etc/#{service.code}.conf  \
          -r #{artifact.name}                                       \
          -e #{environment.code} -U #{user.username}                \
          -H #{hostfile}                                            \
          -d #{deployment.id}
        EOS

        ch.exec script do |ch, success|
          ch.on_data do |c, data|
            if data.strip =~ /^DEPLOYMENT_LOG_DIR\:(.*)$/
              deployment.update_column(:log_path, $1)
              ch.on_close {}
              sleep 1 
              return
            end
          end

          ch.on_extended_data do |c, type, data|
          end

          ch.on_close {}
        end
      end
    end

    deployment.update_column(:ended_at, Time.now)
  end

end
