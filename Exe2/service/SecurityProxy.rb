require 'exception/LoginError'

class SecurityProxy
  
  def initialize(permissionsFile, object)
    @obj = object
    @permissionsFileArray = File.readlines(permissionsFile)
  end
  
  def method_missing(name, *args)
    print 'metodo ', name.to_s, ' no existe. Creando y iniciando....' 
    if args.size < 3
      raise ArgumentError, 'No hay parametros suficientes'
    end
    if @obj.respond_to?(name)
      executeMethod(name, args)
      self.class.send(:define_method,name) do |*params|
        executeMethod(name, params)
      end
    else 
      raise NoMethodError, 'Metodo no existe'
      super
    end
  end
  
  private 
  
  def executeMethod(name, args)
    if isValid(args[0], args[1]) 
      @obj.send(name, *[args[2],args[3]])
    else
      raise LoginError, 'Usuario o contrasena invalidos'
    end
  end
  
  def isValid(user, pass)
    @permissionsFileArray.each do |fileLine|
      userData = fileLine.split(' ');
      if user == userData[0]
        if pass == userData[1]
          return true
        end
      end
    end
    return false
  end
end