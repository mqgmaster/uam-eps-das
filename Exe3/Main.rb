require 'OrdersSystem'
require 'Simulator'

#@author Mauricio Quatrin Guerreiro

class Main
  @machine = OrdersSystem.getStateMachine
  @sim = Simulator.new(@machine,[:validar, 
    :validar, 
    :preparar, 
    :cancelar, 
    :entregar,
    :enviar, 
    :cancelar
  ])
  @sim.start
  
end