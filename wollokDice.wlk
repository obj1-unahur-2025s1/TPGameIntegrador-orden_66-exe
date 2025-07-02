import interfaz.*
import colores.*
import wollok.game.*

object wollokDice {
  var enJuego = false
  var flechas = false
  
  method flechas() = flechas
  
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
    keyboard.r().onPressDo({ interfaz.reiniciar() })
  }
  
  method iniciarGame() {
    if (!enJuego) {
      enJuego = true
      game.removeVisual(fondoInicio)
      game.addVisual(fondoBase)
      self.mostrarSecuencia()
      game.addVisualCharacter(tuNivel)
    }
  }
  
  method continuarGame() {
    self.mostrarSecuencia()
  }
  
  method mostrarSecuencia() {
    flechas = false
    if (game.hasVisual(tuTurnoVersionTexto)) game.removeVisual(
        tuTurnoVersionTexto
      )
    const listadoDeColores = interfaz.secuenciaArealizar()
    var time = if (listadoDeColores.size() == 1) 1500 else 1000
    listadoDeColores.forEach(
      { color =>
        game.schedule(time, { color.mostraryOcultar() })
        time += 1000
      }
    )
    //game.schedule(time, { tuTurno.mostrar() })
    game.schedule(time, { game.addVisualCharacter(tuTurnoVersionTexto) })
    game.schedule(time, { flechas = true })
  }
  
  method tecladoUsuario() {
    keyboard.up().onPressDo({ interfaz.addSecuenciaJugador(rojo) })
    keyboard.down().onPressDo({ interfaz.addSecuenciaJugador(azul) })
    keyboard.right().onPressDo({ interfaz.addSecuenciaJugador(verde) })
    keyboard.left().onPressDo({ interfaz.addSecuenciaJugador(amarillo) })
  }
  
  method ocultarFlechas() {
    flechas = false
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
  override method position() = game.at(15, 10)
  
  method mostraryOcultar() {
    game.addVisual(self)
    game.schedule(2000, { game.removeVisual(self) })
  }
  
  method mostrar() {
    if (not game.hasVisual(self)) game.addVisual(self)
  }
  
  method ocultar() {
    if (game.hasVisual(self)) game.removeVisual(self)
  }
}
