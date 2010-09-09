require File.dirname(__FILE__) + "/router"
require File.dirname(__FILE__) + "/handler"

class MyApp
  def initialize(app)
    @app = app
    @router = Router.map do
      get "/one", "Handler.one"
    end
  end

  def call(env)
    route = @router.get_route(env).split(".")
    puts route
    begin
      handler = eval(route[0]).new
    rescue NameError
      handler = nil
    end
    m = route[1]
    if handler && handler.public_methods.include?(m)
      body = handler.send(m).to_s
      [200, {"Content-Type" => "text/html"}, [body]]
    else
      @app.call env
    end
  end
end

use MyApp

app = lambda do |env|
  body = File.open(File.dirname(__FILE__) + "/404.html", 'r').read
  [404, {"Content-Type" => "text/html"}, [body]]
end
run app