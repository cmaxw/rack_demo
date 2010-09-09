app = lambda do |env|
  request = Rack::Request.new(env)
  params = request.params
  dividend = params["dividend"].to_f
  divisor = params["divisor"].to_f
  quotient = divisor / dividend
  [200, {"Content-Type" => "text/html"}, [quotient.to_s]]
end
run app