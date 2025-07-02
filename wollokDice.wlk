import wollok.game.*
import interfaz.*
import colores.*
import imagenes.*
import textos.*

object wollokDice {
  var enJuego = false
  var flechasActivas = false
  
  method flechas() = flechasActivas
  
  method iniciar() {
    game.width(20)
    game.height(20)
    game.cellSize(51)
    game.title("Wollok Dice")
    game.addVisual(fondoInicio)
    game.start()
    self.initTeclado()
  }
  
  method initTeclado() {
    keyboard.enter().onPressDo({ self.iniciarGame() })
    keyboard.r().onPressDo({ interfaz.reiniciar() })
    keyboard.i().onPressDo({ interfaz.mostrarInstruciones() })
    keyboard.x().onPressDo({ interfaz.mostrarMenu() })
    keyboard.q().onPressDo({ game.stop() })
    keyboard.up().onPressDo({ interfaz.addSecuenciaJugador(rojo) })
    keyboard.down().onPressDo({ interfaz.addSecuenciaJugador(azul) })
    keyboard.right().onPressDo({ interfaz.addSecuenciaJugador(verde) })
    keyboard.left().onPressDo({ interfaz.addSecuenciaJugador(amarillo) })
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
    if (not game.hasVisual(tuNivel)) game.addVisualCharacter(tuNivel)
  }
  
  method mostrarSecuencia() {
    flechasActivas = false
    const listadoDeColores = interfaz.secuenciaArealizar()
    var time = 2000
    listadoDeColores.forEach(
      { color =>
        game.schedule(time, { color.mostraryOcultar() })
        time += 1000
      }
    )
    if (time === 1000) {
      time += 500
    }
    game.schedule(
      time,
      { if (not game.hasVisual(tuTurnoVersionTexto)) game.addVisualCharacter(
            tuTurnoVersionTexto
          ) }
    )
    game.schedule(time, { flechasActivas = true })
  }
  
  method ocultarFlechas() {
    flechasActivas = false
  }
}
