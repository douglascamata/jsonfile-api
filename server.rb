require "json"
require 'pry'

class Server

  JSON_PATH = File.absolute_path("data.json")

  def call(env)
    @json_contents = json_contents = File.read(JSON_PATH)
    collection, id = env['REQUEST_PATH'].split('/')
    if collection == ''
      render_all_data
    elsif collection && !id
      render_collections(collection)
    else
      render_resource(collection, id)
    end
  end

  def render_all_data
    [200, {"Content-Type" => "text/json"}, [json_contents]]
  end

  def render_collections(collection)
    data = JSON.load json_contents
    content = data[collection].to_json
    [200, {"Content-Type" => "text/json"}, [content]]
  end
end
