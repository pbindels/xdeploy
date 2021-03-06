require 'optparse'
require 'erb'
require File.expand_path('app/models/template.rb')

node = Hash.new
node["sfo"]   = { qdeploy_host:  "127.0.0.1",   qdeploy_server:  "sfo-ops-adm-01" }
node["saceng"]   = { qdeploy_host:  "127.0.0.1",   qdeploy_server:  "sac-eng-deploy-web-01" }
node["prod1"] = { qdeploy_host:  "sac-eng-deploy-web-01", qdeploy_server:  "sac-prod1-rel-deploy-01"   }
node["test"] = { qdeploy_host:  "10.110.2.61", qdeploy_server:  "sfo-prod-rel-deploy-01"   }
node["dev"] = { qdeploy_host:  "127.0.0.1", qdeploy_server:  "sfo-qa-devops-web-01"   }
node["devops"] = { qdeploy_host:  "127.0.0.1", qdeploy_server:  "sac-ops-deploy-web-01"   }

options = {}
optparse = OptionParser.new do |opts|
    opts.banner = "Usage: run_cap.rb [options] file1 file2 ..."

      options[:verbose] = false
      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
          options[:verbose] = v
      end

      options[:noop] = false
      opts.on("-n", "--noop", "Run without execution") do |n|
          options[:noop] = true
      end

      options[:logfile] = false
      opts.on("-f", "--logfile FILE", "Write log to FILE") do |file|
          options[:logfile] = file
      end

      opts.on("-l", "--location prod1", "host to deploy to.  Either prod1 or sfo or test") do |location|
          options[:location] = location
      end

      opts.on("-a", "--action deploy|check", "deploy action.  Either check or deploy") do |action|
          options[:action] = action
      end

      opts.on("-h", "--help", "Display this screen") do |v|
          puts opts
          exit
      end
end

optparse.parse!

if options[:location]  

    puts "DEPLOYING TO #{options[:location]} "
    Dir.chdir "config"

    # Substitute location configs into templates
    ["deploy.rb", "qdeploy.yml", "database.yml"].each  do  |file|
      #`cp #{file}.#{options[:location]} #{file}`
      template = File.read("templates/#{file}.erb")
      result_file = File.open("#{file}","w")
      tmpl = Template.new
      tmpl.qdeploy_host = node[options[:location]][:qdeploy_host] 
      tmpl.qdeploy_server = node[options[:location]][:qdeploy_server] 
      result_file << ERB.new(template).result(tmpl.template_binding)
      result_file.close

      puts "Commiting #{file}"
      puts "git commit -m\"deploy to #{options[:location]}\" #{file}"
      `git commit -m\"deploy to #{options[:location]}\" #{file} >> ../#{options[:logfile]} 2>&1`  unless options[:noop]
    end

    puts "git push >> ../#{options[:logfile]} 2>&1"
    `git push >> ../#{options[:logfile]} 2>&1`   unless options[:noop]

    Dir.chdir ".."

    if options[:action] == "deploy"
        puts "Doing deploy"
        sleep 2
        puts "Enter passwd"
        `cap deploy` unless options[:noop]
    elsif options[:action] == "check"
        puts "Doing deploy:check"
        sleep 2
        puts "Enter passwd"
        `cap deploy:check` unless options[:noop]
    else
        puts optparse 
    end

else
    puts optparse 
end


