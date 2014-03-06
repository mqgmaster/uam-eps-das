class DynamicAdapter
  
  def initialize(object)
    @object = object
    @numParamsArray = Hash.new
    @object.class.instance_methods(false).each do |name|
      @numParamsArray[name] = (@object.class.instance_method(name).arity)
    end
  end
  
  def addMethod(methodName, objectMethodsName)
    self.class.send(:define_method,methodName) do |*params|
      objectMethodsName.each do |name|
        @object.send(name, *getArguments(params, @numParamsArray[name.to_sym]))
      end
    end
  end
  
  private
  
  def getArguments(params, numParams)
    if params.compact.size < numParams
      raise ArgumentError, 'No hay parametros suficientes'
    end
    case numParams
    when 0
      return []
    else
      return params[0..numParams-1]
    end
  end
  
end