class Imagen {
  const imagen
  
  method image() = imagen
  
  method position() = game.at(0, 0)
}

const fondoInicio = new Imagen(imagen = "inicioConHighScore.png")

const fondoBase = new Imagen(imagen = "fondoBase.jpg")

const perdiste = new Imagen(imagen = "pantallaPerdiste.jpg")

const intrucciones = new Imagen(imagen = "instrucciones.jpg")

const highScoreImage = new Imagen(imagen = "highScore.jpg")

const highScoreLista = new Imagen(imagen = "highScores.jpg")

const seleccionDificultad = new Imagen(imagen = "seleccionNivel.jpg")

class Texto inherits Imagen {
  override method position() = game.at(15, 13)
}

const tuTurno = new Texto(imagen = "turno.jpg")

class SinHighScore inherits Imagen {
  override method position() = game.at(4, 8)
}

const sinHighScore = new SinHighScore(imagen = "sinHighScore.png")

class VolverIm inherits Imagen {
  override method position() = game.at(6, 1)
}

const volver = new VolverIm(imagen = "volverB.png")
