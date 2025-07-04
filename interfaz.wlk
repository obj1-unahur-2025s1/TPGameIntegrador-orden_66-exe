import textos.*
import wollok.game.*
import colores.*
import wollokDice.*
import imagenes.*

object interfaz {
  var nivel = 1
  const opciones = [rojo, azul, verde, amarillo]
  const property secuencias = []
  const sucuenciasJugador = []
  
  method nivel() = nivel
  
  method opciones() = opciones
  
  method secuenciaArealizar() {
    if (secuencias.size() < nivel) secuencias.add(opciones.randomized().first())
    return secuencias
  }
  
  method subirDeNivel() {
    nivel += 1
    sucuenciasJugador.clear()
  }
  
  method addSecuenciaJugador(unColor) {
    if (wollokDice.flechas()) {
      self.removeImages([tuNivel, turno])
      self.agregarColorYMostrar(unColor)
      
      if (self.esJugadaPerdedora()) {
        self.perder()
      } else {
        if (self.ultimaJugada()) {
          self.subirDeNivel()
          game.schedule(500, { wollokDice.continuarGame() })
        }
      }
    }
  }
  
  method agregarColorYMostrar(unColor) {
    sucuenciasJugador.add(unColor)
    unColor.mostraryOcultar()
  }
  
  method esJugadaPerdedora() = secuencias.take(
    sucuenciasJugador.size()
  ) != sucuenciasJugador
  
  method perder() {
    wollokDice.ocultarFlechas()
    game.addVisual(perdiste)
    wollokDice.perdio()
  }
  
  method ultimaJugada() = sucuenciasJugador.size() == secuencias.size()
  
  method reiniciar() {
    if (wollokDice.reiniciar()) {
      nivel = 1
      secuencias.clear()
      sucuenciasJugador.clear()
      self.removeImages([perdiste])
      game.addVisual(fondoInicio)
      wollokDice.cambiarEnJuego()
    }
  }
  
  method removeImages(unaListaDeImagenes) {
    unaListaDeImagenes.forEach(
      { imagen => if (game.hasVisual(imagen)) game.removeVisual(imagen) }
    )
  }
  
  method mostrarInstruciones() {
    if (!wollokDice.enJuego()) {
      game.removeVisual(fondoInicio)
      game.addVisual(intrucciones)
    }
  }
  
  method mostrarMenu() {
    if (!wollokDice.enJuego()) {
      game.removeVisual(intrucciones)
      game.addVisual(fondoInicio)
    }
  }
}