class Logger
  
  def Logger.print_log(methodName, *args)
    puts " *** LOG *** Se ha llamado al método #{methodName} con los argumentos #{args}"
  end

  def Logger.inject(object)
    object.class.instance_methods(false).each do |name|
      object.class.instance_method(name)
      if name != :method_missing
        object.class.send(:alias_method,("old_" + name.to_s).to_sym, name)
        object.class.send(:define_method,name) do |*args|
          Logger.print_log(name, *args)
          send("old_" + name.to_s,*args)
        end
      end
    end
  end

end