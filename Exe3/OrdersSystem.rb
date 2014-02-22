require 'StateMachineDsl'

class OrdersSystem < StateMachineDsl
  
  machine {
      event :validar
      event :preparar
      event :enviar
      event :entregar
      event :devolver
      event :cancelar
      
      state :pedidoRealizado do 
        transition :cancelar, :pedidoCancelado
        transition :validar, :pedidoValidado
      end
      
      state :pedidoValidado do 
        transition :cancelar, :pedidoCancelado
        transition :preparar, :pedidoPreparado
      end
      
      state :pedidoPreparado do 
        transition :entregar, :pedidoEnviado
      end
      
      state :pedidoEnviado do 
        transition :cancelar, :pedidoCancelado
        transition :devolver, :pedidoCancelado
        transition :enviar, :pedidoEntregado
      end
      
      state :pedidoEntregado
      
      state :pedidoCancelado
  }
  
end