require "json"
require 'pry'

class Server

  JSON_PATH = File.absolute_path("data.json")

  def call(env)
    @json_contents = json_contents = File.read(JSON_PATH)
    collection, id = env['REQUEST_PATH'].split('/')[1..2]
    if collection && id
      render_resource(collection, id)
    elsif collection && !id
      render_collections(collection)
    else
      render_all_data
    end
  end

  def render_all_data
    [200, {"Content-Type" => "text/json"}, [@json_contents]]
  end

  def render_collections(collection)
    data = JSON.load @json_contents
    content = data[collection].to_json
    [200, {"Content-Type" => "text/json"}, [content]]
  end

  def render_resource(collection, id)
    data = JSON.load @json_contents
    binding.pry
    content = data[collection][id.to_i].to_json
    [200, {"Content-Type" => "text/json"}, [content]]
  end
end
