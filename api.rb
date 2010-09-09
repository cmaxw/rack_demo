def define_middleware(verb, path, &block)
  middleware = Class.new
  middleware.send(:define_method, 'action', &block)
  middleware.send(:define_method, 'initialize') {|app| @app = app}
  middleware.instance_eval do
    def verb
      @verb
    end
    
    def verb=(verb)
      @verb=verb
    end
    
    def path
      @path
    end
    
    def path=(path)
      @path = path
    end
  end
  middleware.send(:define_method, 'call') do |env|
    if env["REQUEST_METHOD"] == self.class.verb && env["PATH_INFO"] == self.class.path
      action
    else
      @app.call(env)
    end
  end
  middleware.verb = verb
  middleware.path = path

  use middleware
end

def get(path, &block)
  define_middleware("GET", path, &block)
end

def post(path, &block)
  define_middleware("GET", path, &block)
end

def put(path, &block)
  define_middleware("GET", path, &block)
end

def delete(path, &block)
  define_middleware("GET", path, &block)
end