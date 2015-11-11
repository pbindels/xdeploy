class User < ActiveRecord::Base

  validates_presence_of :username
  validates_uniqueness_of :username

  def permitted?(env, action)
    #env_root = env.gsub(/\d+/,'')
    env_tr = env.gsub(/\d+/,'')
    if env_tr == "qe"
      env_root = "qa"
    elsif env_tr =~ /qa|prod|load|pm|perf/
      env_root = env_tr
    else
      env_root = "int"
    end
    self.send("#{env_root}#{action}")
  end
end
