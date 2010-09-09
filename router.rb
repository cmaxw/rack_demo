class Router
  def initialize
    @map = {:get => {}, :post => {}, :put => {}, :delete => {}}
  end
  
  def get_route(env)
    verb = env["REQUEST_METHOD"].downcase.to_sym
    path = env["PATH_INFO"].downcase
    @map[verb][path]
  end
  
  def self.map(&block)
    router = self.new
    puts router.inspect
    router.instance_eval &block
    router
  end
  
  def method_missing(key, *args)
    if @map.has_key?(key) && args.size == 2
      @map[key][args[0].downcase] = args[1]
    else
      super
    end
  end
end