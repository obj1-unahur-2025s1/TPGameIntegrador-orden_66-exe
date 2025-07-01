import interfaz.*
import colores.*
import wollok.game.*

object wollokDice {
 
method iniciar() {
  game.width(20)
  game.height(20)
  game.cellSize(51)
  game.title("Wollok Dice")
  game.addVisual(fondoBase)
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
  self.setReiniciarTeclado()
  self.mostrarSecuencia()
}
method setReiniciarTeclado() {
    // Desvincula la función anterior del enter
    keyboard.enter().onPressDo({ })
    // Vincula la nueva función al enter
    keyboard.enter().onPressDo({ interfaz.reiniciar() })
  }
  
  method continuarGame() {
    self.mostrarSecuencia()
  }


method mostrarSecuencia() {
  const listadoDeColores = interfaz.secuenciaArealizar()
  var time = 500 
  tuTurno.ocultar() 
  listadoDeColores.forEach(
    { color =>
      game.schedule(time, { color.mostraryOcultar() })
      time += 500 
    }
  )
  game.schedule(time, {
    tuTurno.mostrar()
  })
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

object fondoInicio inherits Imagen (imagen = "inicioPro.jpg") {
  
}

object fondoBase inherits Imagen (imagen = "base.jpeg") {
  
}

object perdiste inherits Imagen (imagen = "perdiste.jpg") {
  
  
  override method position() = game.at(0, 0)
}


object tuTurno inherits Imagen (imagen = "tuTurno.jpg") {
  override method position() = game.at(9, 3)
  
  method mostraryOcultar() {
    game.addVisual(self)
    game.schedule(2000, { game.removeVisual(self) })
  }
  
  method mostrar() {
    game.addVisual(self)
  }
  
  method ocultar() {
    game.removeVisual(self)
  }
}
