import interfaz.*

class Imagen {
  var property position = game.at(0, 0)
  const imagen
  
  method image() = imagen
  
  method position() = position
}

const fondoInicio = new Imagen(imagen = "inicioConHighScore.png")

const fondoBase = new Imagen(imagen = "fondoBase.jpg")

const perdiste = new Imagen(imagen = "pantallaPerdiste.jpg")

const intrucciones = new Imagen(imagen = "instrucciones.jpg")

const highScoreImage = new Imagen(imagen = "highScore.jpg")

const highScoreLista = new Imagen(imagen = "highScores.jpg")

const seleccionDificultad = new Imagen(imagen = "seleccionNivel.jpg")

const tuTurno = new Imagen(imagen = "turno.jpg", position = game.at(15, 13))

const sinHighScore = new Imagen(
  imagen = "sinHighScore.png",
  position = game.at(4, 8)
)

const volver = new Imagen(imagen = "volverB.png", position = game.at(6, 1))

const volverR = new Imagen(
  imagen = "rParaReiniciar.png",
  position = game.at(7, 1)
)

const space = new Imagen(imagen = "space_.jpeg", position = game.at(4, 0))

class Cursor inherits Imagen {
  method mostraryOcultar() {
    if (not game.hasVisual(self)) game.addVisual(self)
    game.schedule(500, { self.ocultar() })
  }
  
  method ocultar() {
    if (game.hasVisual(self)) game.removeVisual(self)
  }
  
  method titilar() {
    game.onTick(1000, "cursor", { self.mostraryOcultar() })
  }
  
  method reubicar(posX, posY) {
    position = game.at(posX, posY)
  }
}

const objCursor = new Cursor(
  imagen = "cursor.png",
  position = game.at(interfaz.pl1(), 4.5)
)
