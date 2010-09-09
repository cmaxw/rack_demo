class Hex
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    params = request.params

    ["dividend", "divisor"].each do |p|
      hex = params[p]
      env['rack.request.query_hash'][p] = eval(hex) if hex.match(/^0x[0-9A-Fa-f]+$/)
    end
    @app.call(env)
  end
end

use Hex

app = lambda do |env|
  request = Rack::Request.new(env)
  params = request.params
  dividend = params["dividend"].to_f
  divisor = params["divisor"].to_f
  quotient = divisor / dividend
  [200, {"Content-Type" => "text/html"}, [quotient.to_s]]
end
run app