class NumericParams
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    params = request.params
    if !params["dividend"].match(/^[0-9]+$/) || !params["divisor"].match(/^[0-9]+$/)
      [500, {"Content-Type" => "text/html"}, ["Your parameters are not numbers."]]
    else
      @app.call env
    end
  end
end

use NumericParams

app = lambda do |env|
  request = Rack::Request.new(env)
  params = request.params
  dividend = params["dividend"].to_f
  divisor = params["divisor"].to_f
  quotient = dividend / divisor
  [200, {"Content-Type" => "text/html"}, [quotient.to_s]]
end
run app