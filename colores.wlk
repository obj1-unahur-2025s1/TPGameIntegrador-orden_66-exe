import wollokDice.*

class Colores inherits Imagen {
  method mostraryOcultar() {
    game.addVisual(self)
    game.schedule(1000, { game.removeVisual(self) })
  }
  
  override method position() = game.at(0, 0)
}

object rojo inherits Colores (imagen = "rojo.jpeg") {
  
}

object azul inherits Colores (imagen = "azul.jpeg") {
  
}

object verde inherits Colores (imagen = "verde.jpeg") {
  
}

object amarillo inherits Colores (imagen = "amarillo.jpeg") {
  
}
