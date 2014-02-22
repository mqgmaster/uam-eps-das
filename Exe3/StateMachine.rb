class StateMachine
  
  def initialize
    @currentStateName = nil;
    @statesHash = Hash.new
  end
  
  def addState(state)
    if @currentStateName == nil
      @currentStateName = state.getName
    end
    @statesHash[state.getName] = state
    @lastStateAdded = state.getName
    #puts 'add state ' + state.getName().to_s
  end
  
  def addLastStateAddedTransition(eventName, nextState)
    @statesHash[@lastStateAdded].addTransition(eventName, nextState)
  end
  
  def getCurrentStateName
    @currentStateName
  end
  
  def sendEvent(name)
    if @nextStateName = @statesHash[@currentStateName].sendEvent(name)
      @currentStateName = @nextStateName
    end
    return @currentStateName
  end
  
end