import interfaz.*
import colores.*
import wollok.game.*

object wollokDice {
  method iniciar() {
    game.width(20)
    game.height(20)
    game.cellSize(51)
    
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
    self.mostrarSecuencia()
  }
  
  method reiniciarGame() {
    self.mostrarSecuencia()
  }
  
  method continuarGame() {
    self.mostrarSecuencia()
  }
  
  method mostrarSecuencia() {
    if (game.hasVisual(tuTurno)) tuTurno.ocultar()
    
    const listadoDeColores = interfaz.secuenciaArealizar()
    var time = if (listadoDeColores.size() == 1) 5000 else 1000
    listadoDeColores.forEach(
      { color =>
        game.schedule(time, { color.mostraryOcultar() })
        time += 1000
      }
    )
    game.schedule(time, { game.addVisual(fondoBase) })
    game.schedule(time + 1000, { tuTurno.mostrar() })
  }
  
  method tecladoUsuario() {
    keyboard.up().onPressDo({ interfaz.addSecuenciaJugador(rojo) })
    keyboard.down().onPressDo({ interfaz.addSecuenciaJugador(azul) })
    keyboard.right().onPressDo({ interfaz.addSecuenciaJugador(verde) })
    keyboard.left().onPressDo({ interfaz.addSecuenciaJugador(amarillo) })
    keyboard.r().onPressDo({ interfaz.reiniciar() })
  }
}

class Imagen {
  const imagen
  
  method image() = imagen
  
  method position() = game.at(0, 0)
}

object fondoInicio inherits Imagen (imagen = "inicioPro.jpg") {
  //override method position() = game.center()
}

object fondoBase inherits Imagen (imagen = "base.jpeg") {
  //override method position() = game.center()
}

object perdiste inherits Imagen (imagen = "perdiste.jpeg") {
  method text() = "PERDISTE, presiona R para ir al inicio"
  
  override method position() = game.at(0, 0)
}

object tuTurno inherits Imagen (imagen = "tuTurno.jpg") {
  override method position() = game.center()
  
  method mostraryOcultar() {
    game.addVisual(self)
    game.schedule(1000, { game.removeVisual(self) })
  }
  
  method mostrar() {
    game.addVisual(self)
  }
  
  method ocultar() {
    game.removeVisual(self)
  }
}
