require "router"
require "handler"
require "handlers/rubyists"
require "handlers/pythonistas"

class MyApp
  def initialize(app)
    @app = app
    @router = Router.map do
      get "/ruby", {:handler => "rubyists", :method => "rubyists"}
      get "/python", {:handler => "pythonistas", :method => "python"}
    end
  end

  def call(env)
    params = @router.get_route(env)
    
    params.each do |k, v|
      env['QUERY_STRING'] << "&" unless env['QUERY_STRING'].empty?
      env['QUERY_STRING'] << "#{k}=#{v}"
    end
    @app.call(env)
  end
end

use MyApp
use Rubyists
use Pythonistas

app = lambda do |env|
  body = File.open(File.dirname(__FILE__) + "/404.html", 'r').read
  [404, {"Content-Type" => "text/html"}, [body]]
end
run app