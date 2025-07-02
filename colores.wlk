import interfaz.*
import wollokDice.*

class Colores inherits Imagen {
  method mostraryOcultar() {
    if (not game.hasVisual(self)) game.addVisual(self)
    game.schedule(1000, { self.ocultar() })
  }
  
  method ocultar() {
    if (game.hasVisual(self)) game.removeVisual(self)
  }
  
  override method position() = game.at(0, 0)
}

object rojo inherits Colores (imagen = "rojoCompleto.jpeg") {
  
}

object azul inherits Colores (imagen = "azulCompleto.jpeg") {
  
}

object verde inherits Colores (imagen = "verdeCompleto.jpeg") {
  
}

object amarillo inherits Colores (imagen = "amarilloCompleto.jpeg") {
  
}
