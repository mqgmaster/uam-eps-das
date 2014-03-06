require "SecureRandom"
require "Date"

#id
#authorUser
#messageTopic
#sentDate

class Message
  
  def initialize(author, topic)
    @id = SecureRandom.uuid()
    @messageTopic = topic
    @authorUser = author
    @sentDate = Date.today
  end
  
  def getAuthor
    @authorUser
  end
  
  def getId
    @id
  end
  
  def getTopic
    @messageTopic
  end
  
  def getSentDate
    @sentDate
  end
  
  def to_s
    return "Fecha del mensaje: " + @sentDate.to_s +
    " | Autor: " + @authorUser.getName + 
    " | Tema: " + @messageTopic
  end
  
end