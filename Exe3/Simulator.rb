class Simulator
  
  def initialize(machine, events)
    @events = events;
    @machine = machine;
  end
  
  def start
    puts 'initial state ' + @machine.getCurrentStateName.to_s
    @events.each do |name|
      puts 'event: ' + name.to_s + ' | current state: ' + @machine.sendEvent(name).to_s
    end
  end
end