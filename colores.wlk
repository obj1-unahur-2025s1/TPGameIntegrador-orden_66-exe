import wollokDice.*

class Colores inherits Imagen {
  method mostraryOcultar() {
    if (not game.hasVisual(self)) game.addVisual(self)
    game.schedule(1000, { self.ocultar() })
  }
  
  method ocultar() {
    if (game.hasVisual(self)) game.removeVisual(self)
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
