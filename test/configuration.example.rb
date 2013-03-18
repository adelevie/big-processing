# usage:
# require_relative "path/to/configuration.rb"
# keys = Configuration.keys
# keys["ironio"]["token"]

module Configuration
  def self.keys
    {
      "ironio" => {
        "project_id" => "123",
        "token"      => "abc"
      },
      "aws" => {
        "token" => "456",
        "id"    => "def"
      }
    }
  end
end