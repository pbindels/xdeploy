class Deployment < ActiveRecord::Base
  include PublicActivity::Model

  belongs_to :project
  belongs_to :service
  belongs_to :environment
  belongs_to :artifact
  belongs_to :user
  
  validates_associated :project
  validates_associated :service
  validates_associated :environment
  validates_associated :artifact
  validates_associated :user
  
  def tokens
    token_list = {}
    token_list["PROJECT_CODE"] = project.code
    token_list["SERVICE_CODE"] = token_list["APPLICATION_NAME"] = service.code
    token_list["ENV_NAME"] = environment.code
    token_list["ENV_ID"] = environment.env_id.to_s.rjust(2, "0")
    token_list["QD_DATE"] = Time.now.strftime("%Y%m%d%H%M%S")
    
    # global tokens
    Token.global.each do |token|
      token_list[token.name] = token.value
    end
    
    # environment tokens
    environment.tokens.each do |token|
      token_list[token.name] = token.value
    end
    
    #project tokens
    project.tokens.each do |token|
      token_list[token.name] = token.value
    end
    
    #service tokens
    service.tokens.each do |token|
      token_list[token.name] = token.value
    end
    
    #environment tokens
    ServiceToEnvironment.find_by(service_id: service.id, environment_id: environment.id).tokens.each do |token|
      token_list[token.name] = token.value
    end
    
    token_list
  end
  
  def properties
    str = tokens.collect{|k, v| "#{k}=#{v}" }.join("\n")
    if !str.blank?
      str = str + "\n"
    end
    str
  end

  def lock_file_path
    service.lock_file(environment.code)
  end
  
  def lock_file
    File.open(lock_file_path)
  end
  
  def prepare_file?
    return false unless log_path
    File.exists?(File.join(log_path, 'prepare'))
  end
  
  def status_file?
    return false unless log_path
    File.exists?(File.join(log_path, 'status'))
  end
  
  def qdeploy_statuses
    statuses = []
    status_file = File.new(File.join(log_path, 'status'))
    status_file.each_line do |line|
      _status = line.split(":")
      statuses << {host: _status[0], script: _status[1], stage: _status[2], progress: _status[3], status: _status[4]}
    end
    statuses
  end

  def performTask(cmd)
    Rails.logger.info "Run: #{cmd}"
    output = system(cmd)
    Rails.logger.info "Curl output: #{output}"
  end
end