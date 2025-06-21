import wollokDice.*

class Flecha inherits Imagen {
  method mostrar() {
    game.addVisual(imagen)
  }
  
  method ocultar() {
    game.removeVisual(imagen)
  }
}

object rojo inherits Flecha (imagen = "flecha_rojo.jpg") {
  
}

object azul inherits Flecha (imagen = "flecha_azul.jpg") {
  
}

object verde inherits Flecha (imagen = "flecha_verde.jpg") {
  
}

object amarillo inherits Flecha (imagen = "flecha_amarillo.jpg") {
  
}
