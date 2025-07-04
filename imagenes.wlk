class Imagen {
  const imagen
  
  method image() = imagen
  
  method position() = game.at(0, 0)
}

const fondoInicio = new Imagen(imagen = "pantallaInicio.jpeg")

const fondoBase = new Imagen(imagen = "fondoBase.jpg")

const perdiste = new Imagen(imagen = "pantallaPerdiste.jpg")

const intrucciones = new Imagen(imagen = "instrucciones.jpg")

class Texto inherits Imagen {
  override method position() = game.at(13, 10)
}

const tuTurno = new Texto(imagen = "turno.jpg")