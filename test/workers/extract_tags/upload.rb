require 'iron_worker_ng'
require_relative '../configuration'
 
config = Configuration.keys

p token = config["ironio"]["token"]
p project_id = config["ironio"]["project_id"]
client = IronWorkerNG::Client.new(:token => token, :project_id => project_id)
 
code = IronWorkerNG::Code::Ruby.new
code.merge_worker 'extract_tags.rb'
code.merge_file '../configuration.rb'
code.merge_gem 'aws-s3'

 
client.codes.create(code)