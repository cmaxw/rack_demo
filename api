class Handler
  def initialize(app)
    @app = app
  end
  
  def call(env)
    request = Rack::Request.new(env)
    params = request.params
    if params["handler"].downcase == self.class.to_s.downcase
      eval(params["method"])
    end
  end
  
  def render(body)
    [200, {"Content-Type" => "text/html"}, [body]]
  end
end