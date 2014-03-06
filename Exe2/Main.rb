require "adapter/DynamicAdapter"
require "domain/Drum"
require "service/RemoteFileService"
require "service/SecurityProxy"
require "debug/Logger"

#@author Mauricio Quatrin Guerreiro 
#@email mauricio.guerreiro@estudiante.uam.es

class Main
  
#  @adapter = DynamicAdapter.new(Drum.new)
#  @adapter.addMethod("play", ["playFloor","playSplash"])
#  @adapter.play
  
  @fileService = RemoteFileService.new
#  @fileService.connect('remote')
#  @fileService.list
#  @fileService.download('remote','Main.rb')
#  @fileService.upload('remote','1.txt')
#  @fileService.delete('remote','1.txt')
#  
  @ftp = DynamicAdapter.new(@fileService)
  @ftp.addMethod('get',['connect','download','disconnect'])
  @ftp.addMethod('ls',['connect','list','disconnect'])
  @ftp.addMethod('puts',['connect','upload','disconnect'])
  @ftp.addMethod('delete',['connect','delete','disconnect'])
#    
#  @ftp.ls('remote')
#  @ftp.puts('remote','1.txt')
#  @ftp.get('remote','1.txt')
#  @ftp.delete('remote','1.txt')
#  
#  @proxy = SecurityProxy.new("users.txt",@ftp)
#
#  @proxy.ls('user1','123','remote')
#  @proxy.puts('user1','123','remote','1.txt')
#  @proxy.ls('user1','123','remote')
#  @proxy.get('user1','123','remote','1.txt')
#  @proxy.delete('user1','123','remote','1.txt')
#  @proxy.puts('user1','123','remote','1.txt')
#  @proxy.delte('user1','123','remote','1.txt')
    
#  Logger.inject(@proxy)
#  @proxy.ls('user1','123','remote')
#  @proxy.puts('user1','123','remote','1.txt')
#  @proxy.ls('user1','123','remote')
#  @proxy.get('user1','123','remote','1.txt')
#  @proxy.delete('user1','123','remote','1.txt')
#  @proxy.ls('user1','123','remote')
#  
end