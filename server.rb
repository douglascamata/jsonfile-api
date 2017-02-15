require "json"

class Server

  JSON_PATH = File.absolute_path("data.json")

  def call(env)
    json_contents = File.read(JSON_PATH)
    [200, {"Content-Type" => "text/json"}, [json_contents]]
  end
end
