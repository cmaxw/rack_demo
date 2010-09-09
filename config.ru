class Rounder
  def initialize(app)
    @app = app
  end

  def call(env)
    status, header, body = @app.call(env)
    rounded_body = sprintf("%.02f", body.first.to_f)
    [status, header, [rounded_body]]
  end
end

use Rounder

app = lambda do |env|
  request = Rack::Request.new(env)
  params = request.params
  dividend = params["dividend"].to_f
  divisor = params["divisor"].to_f
  quotient = dividend / divisor
  [200, {"Content-Type" => "text/html"}, [quotient.to_s]]
end
run app