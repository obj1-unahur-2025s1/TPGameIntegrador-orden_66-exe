import wollok.game.*
import interfaz.*
import colores.*
import imagenes.*
import textos.*

object wollokDice {
  var enJuego = false
  var flechasActivas = false
  var reiniciar = false
  
  method enJuego() = enJuego
  
  method flechas() = flechasActivas
  
  method reiniciar() = reiniciar
  
  method cambiarEnJuego() {
    enJuego = not enJuego
  }
  
  method iniciar() {
    game.width(20)
    game.height(20)
    game.cellSize(51)
    game.title("Wollok Dice")
    game.boardGround("fondoBase.jpg")
    game.addVisual(fondoInicio)
    game.start()
    self.initTeclado()
  }
  
  method initTeclado() {
    keyboard.enter().onPressDo({ self.iniciarGame() })
    keyboard.r().onPressDo({ interfaz.reiniciar() })
    keyboard.i().onPressDo({ interfaz.mostrarInstruciones() })
    keyboard.b().onPressDo({ interfaz.mostrarMenu() })
    keyboard.q().onPressDo({ game.stop() })
    keyboard.up().onPressDo({ interfaz.addSecuenciaJugador(rojo) })
    keyboard.down().onPressDo({ interfaz.addSecuenciaJugador(azul) })
    keyboard.right().onPressDo({ interfaz.addSecuenciaJugador(verde) })
    keyboard.left().onPressDo({ interfaz.addSecuenciaJugador(amarillo) })
  }
  
  method iniciarGame() {
    if (!enJuego) {
      if (game.hasVisual(fondoInicio)) game.removeVisual(fondoInicio)
      game.addVisual(sinColores)
      
      enJuego = true
      reiniciar = false
      flechasActivas = false
      
      game.addVisual(tuNivel)
      
      self.mostrarSecuencia()
    }
  }
  
  method continuarGame() {
    self.mostrarSecuencia()
  }
  
  method mostrarSecuencia() {
    flechasActivas = false
    const listadoDeColores = interfaz.secuenciaArealizar()
    var time = 1000
    if (game.hasVisual(sinColores)) game.schedule(
        time,
        { game.removeVisual(sinColores) }
      )
    
    listadoDeColores.forEach(
      { color =>
        game.schedule(time, { color.mostraryOcultar() })
        time += 1000
      }
    )
    if (time === 1000) {
      time += 500
    }
    game.schedule(time, { game.addVisual(sinColores) })
    game.schedule(
      time,
      { if (not game.hasVisual(tuTurno)) game.addVisual(tuTurno) }
    )
    game.schedule(time, { flechasActivas = true })
  }
  
  method ocultarFlechas() {
    flechasActivas = false
  }
  
  method perdio() {
    reiniciar = true
  }
}
