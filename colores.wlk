import imagenes.Imagen

class Colores inherits Imagen {
  method mostraryOcultar() {
    if (not game.hasVisual(self)) game.addVisual(self)
    game.schedule(1500, { self.ocultar() })
  }
  
  method ocultar() {
    if (game.hasVisual(self)) game.removeVisual(self)
  }
  
  override method position() = game.at(0, 0)
}

const rojo = new Colores(imagen = "rojoCompleto.jpeg")

const azul = new Colores(imagen = "azulCompleto.jpeg")

const verde = new Colores(imagen = "verdeCompleto.jpeg")

const amarillo = new Colores(imagen = "amarilloCompleto.jpeg")
