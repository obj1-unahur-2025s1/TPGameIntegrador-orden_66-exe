import wollok.game.*
import interfaz.*
import colores.*
import imagenes.*
import textos.*
import sonidos.*
import Puntuacion.*

object wollokDice {
  var enJuego = false
  var flechasActivas = false
  var reiniciar = false
  const musicaDeFondo = new GameMusic()
  const musicaMenu = new MenuMusic()
  
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
    sonido.ejecutar(musicaMenu)
    game.start()
    self.initTeclado()
  }
  
  method initTeclado() {
    keyboard.enter().onPressDo({ self.iniciarGame() })
    keyboard.r().onPressDo({ interfaz.reiniciar() })
    keyboard.i().onPressDo({ interfaz.mostrarInstruciones() })
    keyboard.b().onPressDo({ interfaz.mostrarMenu() })
    
    keyboard.p().onPressDo({ game.stop() }) //NO SE USA
    
    keyboard.w().onPressDo({ interfaz.addSecuenciaJugador(rojo) })
    keyboard.s().onPressDo({ interfaz.addSecuenciaJugador(azul) })
    keyboard.d().onPressDo({ interfaz.addSecuenciaJugador(verde) })
    keyboard.a().onPressDo({ interfaz.addSecuenciaJugador(amarillo) })
  }
  
  method iniciarGame() {
    if (!enJuego) {
      if (game.hasVisual(fondoInicio)) game.removeVisual(fondoInicio)
      game.addVisual(sinColores)
//
      puntos.addVisual()
      puntos.ubicar()
      if (sonido.enEjecucion(musicaMenu)) sonido.detener(musicaMenu)
      sonido.ejecutar(musicaDeFondo)
      enJuego = true
      reiniciar = false
      flechasActivas = false
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
      time += 1000
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
    if (sonido.enEjecucion(musicaDeFondo)) sonido.detener(musicaDeFondo)
    reiniciar = true
  }
}
