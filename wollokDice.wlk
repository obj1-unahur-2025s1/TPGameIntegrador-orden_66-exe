import interfaz.*
import colores.*
import wollok.game.*

object wollokDice {
  method iniciar() {
    game.width(20)
    game.height(20)
    //game.cellSize(20)
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
    //game.removeVisual(fondoInicio)
    self.mostrarSecuencia()
  }
  
  method continuarGame() {
    //game.removeVisual(fondoBase)
    self.mostrarSecuencia()
  }
  
  method mostrarSecuencia() {
    const listadoDeColores = interfaz.secuenciaArealizar()
    var time = 1000
    listadoDeColores.forEach(
      { color =>
        game.schedule(time, { color.mostraryOcultar() })
        time += 1000
      }
    )
    game.schedule(time - 1000, { game.addVisual(fondoBase) })
  }
  
  method tecladoUsuario() {
    keyboard.up().onPressDo({ interfaz.addSecuenciaJugador(rojo) })
    keyboard.down().onPressDo({ interfaz.addSecuenciaJugador(azul) })
    keyboard.right().onPressDo({ interfaz.addSecuenciaJugador(verde) })
    keyboard.left().onPressDo({ interfaz.addSecuenciaJugador(amarillo) })
  }
}

class Imagen {
  const imagen
  
  method image() = imagen
  
  method position() = game.at(0, 0)
}

object fondoInicio inherits Imagen (imagen = "inicio.jpeg") {
  //override method position() = game.center()
}

object fondoBase inherits Imagen (imagen = "base.jpeg") {
  //override method position() = game.center()
}
