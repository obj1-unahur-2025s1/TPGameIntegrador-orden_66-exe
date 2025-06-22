import interfaz.*
import colores.*
import wollok.game.*

object wollokDice {
  method iniciar() {
    game.width(50)
    game.height(50)
    game.cellSize(50)
    game.title("Wollok Dice")
    game.addVisual(fondoInicio)
    game.start()
    self.initTeclado()
    self.tecladoUsuario()
  }
  
  method initTeclado() {
    keyboard.enter().onPressDo({ self.iniciarGame() })
  }
  
  method iniciarGame() {
    game.removeVisual(fondoInicio)
    const listadoDeColores = interfaz.secuenciaArealizar()
    var time = 1000
    listadoDeColores.forEach(
      { color =>
        game.schedule(time, { color.mostraryOcultar() })
        time += 1000
      }
    )
    game.schedule(time + 1000, { game.addVisual(fondoInicio) })
  }
  
  method tecladoUsuario() {
    keyboard.w().onPressDo({ interfaz.addSecuenciaJugador(rojo) })
    keyboard.s().onPressDo({ interfaz.addSecuenciaJugador(azul) })
    keyboard.d().onPressDo({ interfaz.addSecuenciaJugador(verde) })
    keyboard.a().onPressDo({ interfaz.addSecuenciaJugador(amarillo) })
  }
}

class Imagen {
  const imagen
  
  method image() = imagen
  
  method position() = game.at(0, 0)
}

object fondoInicio inherits Imagen (imagen = "fondo1.jpg") {
  
}
