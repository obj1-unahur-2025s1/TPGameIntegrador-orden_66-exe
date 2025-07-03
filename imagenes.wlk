class Imagen {
  const imagen
  
  method image() = imagen
  
  method position() = game.at(0, 0)
}

const fondoInicio = new Imagen(imagen = "pantallaInicio.jpeg")

const fondoBase = new Imagen(imagen = "base.jpeg")

const perdiste = new Imagen(imagen = "pantallaPerdiste.jpg")

const intrucciones = new Imagen(imagen = "instrucciones.jpg")
