require "api"

get "/chuck" do
  [200, {"Content-Type" => "text/html"}, ["Chuck has mad coder skills!"]]
end

app = lambda do |env|
  body = File.open(File.dirname(__FILE__) + "/404.html", 'r').read
  [404, {"Content-Type" => "text/html"}, [body]]
end
run app