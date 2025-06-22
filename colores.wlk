import wollokDice.*

class Colores inherits Imagen {
  method mostraryOcultar() {
    game.addVisual(self)
    game.schedule(1000, { game.removeVisual(self) })
  }
  
  override method position() = game.center()
}

object rojo inherits Colores (imagen = "flecha_rojo.jpg") {
  
}

object azul inherits Colores (imagen = "flecha_azul.jpg") {
  
}

object verde inherits Colores (imagen = "flecha_verde.jpg") {
  
}

object amarillo inherits Colores (imagen = "flecha_amarilla.jpg") {
  
}
