require "SecureRandom"

#id
#name

class User
  
  def initialize(name)
    @id = SecureRandom.uuid()
    @name = name
    @autoReplyNewsEnabled = false
    @autoReplyNewsMessage = nil
  end
  
  def getId
    @id
  end
  
  def getName
    @name
  end
  
  def setEnabled(bool)
    @autoReplyNewsEnabled = bool
  end
  
  def setAutoReplyNewsMessage(message)
    @autoReplyNewsMessage = message
  end
  
  def sendMessage(message)
    if @autoReplyNewsEnabled and message.instance_of?(NewsMessage) and message.getAuthor.getId != @id
      puts "recebi uma noticia"
    end
    puts @name + " ha recibido: " + message.to_s
  end
end