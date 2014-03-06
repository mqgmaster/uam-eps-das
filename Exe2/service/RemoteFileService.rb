require 'FileUtils'

class RemoteFileService
  
  #conectarDirectorioRemoto
  def connect(remoteDir)
    @remoteDir = remoteDir
    @localDir = 'local'
    @enabled = true
    puts "Servicio activado"
  end
  
  #copiarFicheroRemotoADirectorioLocal
  def download(remoteDir, filename)
    if @enabled 
      FileUtils.cp(remoteDir + '/' + filename, @localDir)
      puts "Archivo descargado"
    else
      puts "Servicio no está activo"
    end
  end
  
  #copiarFicheroLocalADirectorioRemoto
  def upload(remoteDir, filename)
    if @enabled
      FileUtils.cp(@localDir + '/' + filename, remoteDir)
      puts "Archivo cargado"
    else
      puts "Servicio no está activo"
    end
  end
  
  #borrarFicheroRemoto
  def delete(remoteDir, filename)
    if @enabled
      FileUtils.rm(remoteDir + '/' + filename)
      puts 'Archivo apagado'
    else
      puts "Servicio no está activo"
    end
  end
 
  #listarFicherosRemotos
  def list
    if @enabled
      puts Dir.entries(@remoteDir)
    else
      puts "Servicio no está activo"
    end
  end
  
  #desconectarDirectorioRemoto
  def disconnect
    puts "Servicio desactivado"
    @enabled = false
  end
end