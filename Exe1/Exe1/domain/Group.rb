require "SecureRandom"

#id
#name
#childGroupsHash
#parentGroupsHash
#usersHash
#maxUsers

class Group
  
  def initialize(name, maxUsers)
    @id = SecureRandom.uuid()
    @name = name
    @maxUsers = maxUsers
    @usersHash = Hash.new
    @childGroupsHash = Hash.new
    @parentGroupsHash = Hash.new
  end  
  
  def getId
    @id
  end
    
  def getName
    @name
  end
  
  def getTotalUsers
    return @usersHash.size()
  end
  
  def getSlotUsers
    return @maxUsers - getTotalUsers
  end
  
  def getFamilyUserSlots
    @familySlots = getSlotUsers
    @parentGroupsHash.each do |id, g|
      @parentSlots = g.getFamilyUserSlots()
      if @parentSlots < @familySlots
        @familySlots = @parentSlots
      end
    end
    return @familySlots
  end
  
  def hasFamilyUserSlot
    return getFamilyUserSlots > 0
  end
  
  def getChildTotalUsers
    @totalUsers = getTotalUsers
    @childGroupsHash.each do |id, g|
      @totalUsers += g.getChildTotalUsers()
    end
    return @totalUsers
  end
    
  #sourceGroup refere-se ao grupo que está solicitando essa informacao  
  #e que obviamente nao tera que responder uma pergunta que ele mesmo enviou
  def hasUser(user, sourceGroup)    
    if @usersHash.has_key?(user.getId)
      return true #ja tenho esse user
    else       
      #puts "checando os pais"
      @parentGroupsHash.each do |id, g|
        if g.getId != sourceGroup.getId
          if g.hasUser(user, self)
            return true
          end
        end          
      end
      #puts "checando os filhos"
      @childGroupsHash.each do |id, g|
        if g.getId != sourceGroup.getId
          if g.hasUser(user, self)
            return true
          end
        end          
      end
      #nem pais nem filhos tem o user entao posso adiciona-lo
      return false
    end    
  end
  
  def hasChildsWithThisUser(user)    
    if @usersHash.has_key?(user.getId)
      return true #tenho esse user
    else            
      #puts "checando os filhos"
      @childGroupsHash.each do |id, g|
        if g.hasChildsWithThisUser(user)
          return true
        end          
      end
      #nenhum filho tem o user
      return false
    end    
  end
  
  #sourceGroup refere-se ao grupo que está solicitando essa informacao  
  #e que obviamente nao tera que responder uma pergunta que ele mesmo enviou
  def checkGroup(group, sourceGroup) 
    if @id == group.getId
      #puts "grupo nao pode ser filho dele mesmo"
      return false
    end
    @usersHash.each do |id, user|
      if group.hasChildsWithThisUser(user)
        #puts "ese grupo tiene usuarios que ya estan en la familia"
        return false
      end        
    end    
    #puts "vamos ver se meus pais nao tem algum user desse grupo"
    @parentGroupsHash.each do |id, g|
      if g.getId != sourceGroup.getId 
        if !g.checkGroup(group, self)
          #puts "parente em um dos pais detectado"
          return false
        end
      end        
    end
    #puts "vamos ver se meus filhos nao tem algum user desse grupo"
    @childGroupsHash.each do |id, g|
      if g.getId != sourceGroup.getId 
        if !g.checkGroup(group, self)
          #puts "parente em um dos filhos detectado"
          return false
        end
      end        
    end
    #puts "grupo nao eh parente"
    return true
  end
  
  def addUser(user)  
    if hasFamilyUserSlot      
      if hasUser(user, self)
        puts "usuario ya esta en el grupo"
        return false    
      end
      puts "usuario " + user.getName + " fue aceptado en el grupo " + @name
      @usersHash[user.getId] = user   
      return true
    end
    puts "no hay espacio en esta familia"
  end
  
  def addChildGroup(group)
    if getFamilyUserSlots < group.getChildTotalUsers
      puts "grupo " + @name + " no suporta la cantidad de usuarios del grupo " + group.getName
      return false
    end
    if !checkGroup(group, self)
      puts "grupo " + group.getName() + " NO fue aceptado como hijo del grupo " + @name
      return false    
    end
    puts "grupo " + group.getName() + " fue aceptado como hijo del grupo " + @name
    @childGroupsHash[group.getId] = group 
    group.addParentGroup(self)  
    return true
  end
  
  def deleteUser(user)
    @usersHash.has_key?(user.getName())
    @usersHash.delete(user)
  end
  
  def printUsers
    @usersHash.each do |id, user|
      puts "usuarios del grupo " + @name + ": " + user.getName        
    end   
  end
  
  def printGroups
    @parentGroupsHash.each do |id, g|
      puts "padres del grupo " + @name + ": " + g.getName          
    end  
    @childGroupsHash.each do |id, g|
      puts "hijos del grupo " + @name + ": " + g.getName          
    end   
  end
  
  def deleteGroup(group)    
    @groupsHash.has_key?(group.getId())
    @groupsHash.delete(group)
  end
  
  def sendMessage(message)
    @childGroupsHash.each do |id, g|
      g.sendMessage(message)
    end
    @usersHash.each do |id, user|
      user.sendMessage(message)
    end
  end

  protected
  
  def addParentGroup(group) 
    @parentGroupsHash[group.getId] = group
  end
  
end