require 'rubygems'
require 'mysql2'
require 'digest'
require 'active_support'
require 'optparse'

options = {}
optparse = OptionParser.new do |opts|
    opts.banner = "Usage: import_tokens.rb [options] file1 file2 ..."

      options[:verbose] = false
      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
            options[:verbose] = v
      end

      options[:noop] = false
      opts.on("-n", "--noop", "Run without execution") do |n|
            options[:noop] = true 
      end

      options[:logfile] = false
      opts.on("-l", "--logfile FILE", "Write log to FILE") do |file|
            options[:logfile] = file 
      end

      options[:project] = false
      opts.on("-p", "--project PROJECT", "Project to import PROJECT") do |project|
            options[:project] = project 
      end

      opts.on("-h", "--help", "Display this screen") do |v|
           puts opts
           exit
      end
end

optparse.parse!

puts "Being verbose" if options[:verbose]
puts "Running without submit" if options[:noop]
puts "Logging to file: #{options[:logfile]}" if options[:logfile]
puts "Importing project: #{options[:project]}" if options[:project]    

digest_secret = Digest::SHA1.hexdigest("SECRET")
encryptor ||= ActiveSupport::MessageEncryptor.new(digest_secret)
encrypted_value = 'SGM2Q0F1cGEwL0t5bWVXQWRvZUJKUT09LS1MT0RJNlBkeS9ZenJuT3Q2eVRwWWxBPT0=--21b09ffed8af5ad25df2057cf0e3c7356b2c1640'
decrypt_val = encryptor.decrypt_and_verify(encrypted_value)
puts decrypt_val

db = Mysql2::Client.new(:host => 'localhost', :username => 'oklrelease',  :password => 'oklrelease', :socket => '/okl/qdeploy/mysql/run/mysql.sock', :database => options[:project], :defaults_file => '/okl/qdeploy/mysql/conf/my.cnf')
db2 = Mysql2::Client.new(:host => 'localhost', :username => 'oklrelease',  :password => 'oklrelease', :socket => '/okl/qdeploy/mysql/run/mysql.sock', :database => 'qdeploy', :defaults_file => '/okl/qdeploy/mysql/conf/my.cnf')

keys = db.query("SELECT * FROM env_properties ", :as => :hash)

#insert into tokens values(NULL,'Service','5','FFFF','SGM2Q0F1cGEwL0t5bWVXQWRvZUJKUT09LS1MT0RJNlBkeS9ZenJuT3Q2eVRwWWxBPT0=--21b09ffed8af5ad25df2057cf0e3c7356b2c1640',NOW(),NOW());
#keys.each do |row|
#  puts row["key_name"]
#  puts row["prod"]
#  puts row["description"]
  #db.query("INSERT INTO tokens values(NULL,'Service','5',\'#{row["name"]}\',\'#{row["encrypted_value"]}\',NOW(),NOW())")
#end

outF = File.open(options[:logfile],"w")

keys.each do |row|

  next if row["key_name"] == "ENV_ID" or row["key_name"] == "ENV_NAME"
  outF.puts "AB_TEST DEPLOYER KEY       : #{row["key_name"]}"
  outF.puts "DEPLOYER INT  VALUE: #{row["int01"]}"
  outF.puts "DEPLOYER PROD VALUE: #{row["prod"]}"

  qkeys = db2.query("select * from tokens where name = \'#{row["key_name"]}\' and tokenable_type IS NULL")

  qkeys.each do |row2|

    encrypted_value = row2["encrypted_value"]
    decrypt_val = encryptor.decrypt_and_verify(encrypted_value)

    outF.puts "QDEPLOY VALUE:  #{decrypt_val}"
    outF.puts "#{row["int01"]} - #{decrypt_val}"

    if row["int01"] != decrypt_val
      enc = encryptor.encrypt_and_sign(row["int01"]) 
      outF.puts "CREATE SERVICE LEVEL TOKEN"
      outF.puts "       QDEPLOY KEY    : #{row2["name"]}"
      outF.puts "       QDEPLOY VALUE  : #{row["int01"]}"
      outF.puts "       DESC           : #{row["description"]}"
      outF.puts "       ENCRYPT        : #{enc}"
      outF.puts("INSERT INTO tokens values(NULL,'Service','13',\'#{row2["name"]}\',\'#{enc}\',NOW(),NOW(),\'#{row["description"]}\')")
      #db2.query("INSERT INTO tokens values(NULL,'Service','13',\'#{row2["name"]}\',\'#{enc}\',NOW(),NOW(),\'#{row["description"]}\')") if ! options[:noop]
    end

    outF.puts "#{row["prod"]} - #{row["int01"]}"

    if row["prod"] !=  row["int01"] 
      enc = encryptor.encrypt_and_sign(row["prod"]) 
      outF.puts "CREATE PROD ENV LEVEL TOKEN"
      outF.puts "       QDEPLOY KEY    : #{row["key_name"]}"
      outF.puts "       QDEPLOY VALUE  : #{row["prod"]}"
      outF.puts "       DESC           : #{row["description"]}"
      outF.puts "       ENCRYPT        : #{enc}"
      outF.puts("INSERT INTO tokens values(NULL,'ServiceToEnvironment','100',\'#{row2["name"]}\',\'#{enc}\',NOW(),NOW(),\'#{row["description"]}\')")
      #db2.query("INSERT INTO tokens values(NULL,'ServiceToEnvironment','100',\'#{row2["name"]}\',\'#{enc}\',NOW(),NOW(),\'#{row["description"]}\')") if ! options[:noop]
    end
  end
  
  if qkeys.size == 0
    enc = encryptor.encrypt_and_sign(row["int01"]) 
    outF.puts "CREATE GLOBAL LEVEL TOKEN"
    outF.puts "       QDEPLOY KEY    : #{row["key_name"]}"
    outF.puts "       QDEPLOY VALUE  : #{row["int01"]}"
    outF.puts "       DESC           : #{row["description"]}"
    outF.puts "       ENCRYPT        : #{enc}"
    outF.puts(     "INSERT INTO tokens (`name`  `encrypted_value`, `created_at`m `updated_at`, `description`) values (\'#{row["key_name"]}\',  \'#{enc}\', NOW(), NOW(), \'#{row["description"]}\')")
    #db2.query("INSERT INTO tokens (`name`, `encrypted_value`, `created_at`, `updated_at`, `description`) values (\'#{row["key_name"]}\',  \'#{enc}\', NOW(), NOW(), \'#{row["description"]}\')") if ! options[:noop]

    outF.puts "#{row["int01"]} -   #{row["prod"]}"

    if row["int01"] != row["prod"]
      enc = encryptor.encrypt_and_sign(row["prod"]) 
      outF.puts "CREATE PROD ENV LEVEL TOKEN"
      outF.puts "       QDEPLOY KEY    : #{row["key_name"]}"
      outF.puts "       QDEPLOY VALUE  : #{row["prod"]}"
      outF.puts "       DESC           : #{row["description"]}"
      outF.puts "       ENCRYPT        : #{enc}"
      outF.puts("INSERT INTO tokens values(NULL,'ServiceToEnvironment','100',\'#{row["key_name"]}\',\'#{enc}\',NOW(),NOW(),\'#{row["description"]}\')")
      #db2.query("INSERT INTO tokens values(NULL,'ServiceToEnvironment','100',\'#{row["key_name"]}\',\'#{enc}\',NOW(),NOW(),\'#{row["description"]}\')") if ! options[:noop]
    end
  end

  outF.puts "----------------------------------------------------------"
end 

