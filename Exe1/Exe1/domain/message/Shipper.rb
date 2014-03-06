require "SecureRandom"

#subscriptions
#messages
#maxStock

class Shipper

  def initialize(name, topic, maxStock)
    @id = SecureRandom.uuid()
    @subscriptions = Hash.new
    @messages = Hash.new
    @maxStock = maxStock
  end
  
  def getId
    @id
  end
  
  #hay que tener cuidado pues un deadlock puede ocurrir muy facil
  def subscribe(subscriber)
    if @id != subscriber.getId
      @subscriptions[subscriber.getId] = subscriber
      return true
    end
    return false
  end
  
  def sendMessage(message)
    if @maxStock > @messages.size()
      @messages[message.getId] = message
      sendToSubscribers(message)
      return true
    end
    puts "El distribuidor ha llegado al limite de su capacidad"
    return false
  end
  
  def deleteMessagesBeforeOf(date)
  end
  
  def getEventsAndConferencesBetween(firstDate, lastDate)
  end
  
  private
  
  def sendToSubscribers(message)
    @subscriptions.each do |id, s|
      s.sendMessage(message)
    end
  end
  
end