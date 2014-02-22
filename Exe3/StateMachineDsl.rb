require 'StateMachine'
require 'State'

class StateMachineDsl
  
  def self.machine
    @machine = StateMachine.new
    yield if block_given?
  end
  
  def self.event(name)
    #only for friendly representation of DSL. This entity is not required.
  end
  
  def self.state(name)
    @s = State.new(name)
    @machine.addState(@s)
    yield if block_given?
  end
  
  def self.transition(eventName, nextState)
    @machine.addLastStateAddedTransition(eventName, nextState)
  end
  
  def self.getStateMachine
    @machine
  end
  
end