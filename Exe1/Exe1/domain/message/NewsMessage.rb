require "domain/message/Message"

#newsContent
#newsParent - NewsMessage

class NewsMessage < Message
  
  def initialize(author, topic, text, parent=nil)
    super(author, topic)
    @newsContent = text 
    @newsParent = parent
  end
  
  def getNewsParent
    @newsParent
  end
  
  def getNewsContent
    @newsContent
  end
  
  def to_s
    if @newsParent
      @newsParentTopic = " | Respuesta al: " + @newsParent.getTopic
    else
      @newsParentTopic = ""
    end
    return super.to_s +
      " | Mensaje: " + @newsContent + @newsParentTopic
  end
  
end