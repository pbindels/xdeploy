require 'rubygems'
require 'mysql2'
require 'yaml'

# how the project and service ids line up for projects that we need to move tokens for
# hostmgr project 6, service 5
# searchpro project 8, service 7
# dashingts project 4, service 3
# colorapi project 9, service 8

#if we want to load from config file
#config = YAML::load_file("config/database.yml")["production"]
#config["host"] = config["hostname"]
#client = Mysql2::Client.new(config)

db = Mysql2::Client.new(:host => 'localhost', :username => "oklrelease", :password => "oklrelease",  :socket => '/okl/qdeploy/mysql/run/mysql.sock', :database => 'qdeploy')
results = db.query("SELECT * FROM tokens where tokenable_type = 'PROJECT' and tokenable_id = 9", :as => :hash)
##insert into tokens values(NULL,'Service','5','FFFF','SGM2Q0F1cGEwL0t5bWVXQWRvZUJKUT09LS1MT0RJNlBkeS9ZenJuT3Q2eVRwWWxBPT0=--21b09ffed8af5ad25df2057cf0e3c7356b2c1640',NOW(),NOW());

results.each do |row|
  row.each do |k,v|
    puts " #{k} -  #{v}"
  end
  puts "#{row["name"]} - #{row["encrypted_value"]}"
  db.query("INSERT INTO tokens values(NULL,'Service','8',\'#{row["name"]}\',\'#{row["encrypted_value"]}\',NOW(),NOW())")
  puts "db.query(\"INSERT INTO tokens values(NULL,'Service','8',\'#{row["name"]}\',\'#{row["encrypted_value"]}\',NOW(),NOW())\")"
  puts "---------------------------\n\n\n"
end

