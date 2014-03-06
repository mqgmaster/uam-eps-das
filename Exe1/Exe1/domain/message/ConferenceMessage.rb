require "domain/message/Message"

#conferenceDate
#conferenceLocation

class ConferenceMessage < Message
  
  def initialize(author, topic, date, location)
    super(author, topic)
    @conferenceDate = date 
    @conferenceLocation = location
  end
  
  def to_s
    return super.to_s +
        " | Fecha de la reunión: " + @conferenceDate.to_s + 
        " | Ubicación de la reunión: " + @conferenceLocation
  end
end