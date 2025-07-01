import wollokDice.*

// 3er archivo: Colores.wlk
class Colores inherits Imagen {
  method mostraryOcultar() {
    game.addVisual(self)
    game.schedule(500, { game.removeVisual(self) })
  }
  
  override method position() = game.at(6, 10)
}

object rojo inherits Colores (imagen = "rojo.jpg") {
  
}

object azul inherits Colores (imagen = "azul.jpg") {
  
}

object verde inherits Colores (imagen = "verde.jpg") {
  
}

object amarillo inherits Colores (imagen = "amarillo.jpg") {
  
}
