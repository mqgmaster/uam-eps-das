require "domain/message/Message"

#eventDate

class EventMessage < Message
  
  def initialize(author, topic, date)
    super(author, topic)
    @eventDate = date 
  end
  
  def to_s
    return super.to_s +
        " | Fecha del evento: " + @eventDate.to_s
  end
  
end