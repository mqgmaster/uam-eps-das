require "SecureRandom"

class Analyzer
  
  def initialize(user, amount)
      @id = SecureRandom.uuid()
      @amountReceived = 0
      @amount = amount
      @targetUserId = user.getId
  end
  
  def getId
    @id
  end
  
  def sendMessage(message)
    if @targetUserId == message.getAuthor.getId
      @amountReceived += 1
      if @amountReceived == @amount
        puts "# usuario " + message.getAuthor.getName + " ha enviado " + @amount.to_s + " mensajes"
        @amountReceived = 0
      end
    end
  end
  
end