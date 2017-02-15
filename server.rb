require "json"
require 'pry'

class Server

  JSON_PATH = File.absolute_path("data.json")

  def call(env)
    json_contents = File.read(JSON_PATH)
    data = JSON.load json_contents
    collection = env['REQUEST_PATH'].gsub('/', '')
    content = data[collection].to_json
    [200, {"Content-Type" => "text/json"}, [content]]
  end
end
