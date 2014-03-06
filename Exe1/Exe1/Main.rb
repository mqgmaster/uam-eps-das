require "domain/Group"
require "domain/User"
require "domain/message/NewsMessage"
require "domain/message/ConferenceMessage"
require "domain/message/EventMessage"
require "domain/message/Shipper"
require "domain/message/Logger"
require "domain/message/Analyzer"
require "Date"

#@author Mauricio Quatrin Guerreiro

class Main
  @g1 = Group.new("1", 1)
  @g2 = Group.new("2", 2)
  @g3 = Group.new("3", 3)
  @u = User.new("Juarez")
  @u2 = User.new("Mestre")
  @g3.addUser(@u2)
  @g1.addUser(@u)
  
  @g2.addUser(@u)   
  @g2.addChildGroup(@g3)
  @g2.addChildGroup(@g3)
  @g3.addChildGroup(@g2) 
  @g3.addChildGroup(@g1) 
  @g1.printUsers()
  @g2.printUsers()
  @g3.printUsers()
  @g1.printGroups()
  @g2.printGroups()
  @g3.printGroups()
 
  @m1 = NewsMessage.new(@u, "Brasil campeon", "Los mejores")
  @m2 = NewsMessage.new(@u, "Brasil campeon", "A ver que tal en la Copa del Mundo! jajaja", @m1)
  @s1 = Shipper.new("1", "Futebol", 2)
  @s2 = Shipper.new("2", "Futebol", 2)
  @s1.subscribe(@s2)
  
  @l = Logger.new("mensajes")
  @s2.subscribe(@l)
  
  @a = Analyzer.new(@u,2)
  @s2.subscribe(@a)
  
  @s2.subscribe(@g2)
  
  @s1.sendMessage(@m1)
  @s1.sendMessage(@m2)

end