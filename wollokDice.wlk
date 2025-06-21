import interfaz.*
import colores.*
import wollok.game.*

object wollokDice {
  method iniciar() {
    game.width(15)
    game.height(10)
    game.cellSize(64)
    game.title("Wollok Dice")
    game.addVisual(fondoMenu)
    game.start()
    self.initTeclado()
  }
  
  method initTeclado() {
    keyboard.w().onPressDo({ interfaz.addSecuenciaJugador(rojo) })
    keyboard.s().onPressDo({ interfaz.addSecuenciaJugador(azul) })
    keyboard.d().onPressDo({ interfaz.addSecuenciaJugador(verde) })
    keyboard.a().onPressDo({ interfaz.addSecuenciaJugador(amarillo) })
    
    keyboard.enter().onPressDo({ self.iniciarGame() })
    keyboard.c().onPressDo({ self.continuar() })
  }
  
  method iniciarGame() {
    game.removeVisual(fondoMenu)
    const listadeColores = interfaz.secuenciaArealizar()
    rojo.mostrar()
  }
  
  method continuar() {
    rojo.ocultar()
  }
}

class Imagen {
  const imagen
  
  method image() = imagen
  
  method position() = game.at(0, 0)
}

object fondoMenu inherits Imagen (imagen = "fondo1.jpeg") {
  
}
