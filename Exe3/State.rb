class State
  
  def initialize(name)
    @name = name;
    @transitionsHash = Hash.new
  end
  
  def getName
    @name
  end
  
  def sendEvent(name)
    if @transitionsHash.has_key?(name)
      return @transitionsHash[name]
    else 
      return false
    end
  end
  
  def addTransition(eventName, nextState)
    @transitionsHash[eventName] = nextState
    #puts 'add transition ' + eventName.to_s + ' => ' + nextState.to_s
  end
  
end