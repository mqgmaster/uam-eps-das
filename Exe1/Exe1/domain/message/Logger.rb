require "SecureRandom"

#dir

class Logger
  
  def initialize(dir)
    @id = SecureRandom.uuid()
    if !File.exists?(dir)
      Dir.mkdir(dir)
    end
    @dir = dir
  end
  
  def getId
    @id
  end
  
  def sendMessage(message)
    File.open(@dir + '\msg' + message.getId + '.html', 'w') do |f|  
      f.puts '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'
      f.puts "<html>"
      f.puts "<head>"
      f.puts '<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">'
      f.puts "</head>"
      f.puts "<body>"
      f.puts "<h1>Noticia #" + message.getId + ": " + message.getTopic + "</h1>"
      f.puts "<h2>De: " + message.getAuthor.getName + "</h2>"
      if message.getNewsParent
        f.puts '<h3>Respuesta al mensaje <a href="msg' + 
          message.getNewsParent.getId + '.html">' + message.getNewsParent.getId + '</a></h3>'
      end
      f.puts message.getNewsContent
      f.puts "</body>"
      f.puts "</html>"
    end 
  end
  
end