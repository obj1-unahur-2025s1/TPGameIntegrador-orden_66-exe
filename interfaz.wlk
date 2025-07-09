import textos.*
import wollok.game.*
import colores.*
import wollokDice.*
import imagenes.*
import sonidos.*
import Puntuacion.*


object interfaz {
  var nivel = 1
  var dificultad = "facil"
  const opciones = [rojo, azul, verde, amarillo]
  const property secuencias = []
  const sucuenciasJugador = []
  
  method nivel() = nivel
  
  method opciones() = opciones

  method setDificultad(unaDificultad) {
  dificultad = unaDificultad
}

method prepararNivelInicial() {
  if (dificultad == "dificil") {
    nivel = 4
  } else {
    nivel = 1
  }
  secuencias.clear()
  sucuenciasJugador.clear()   
}


  
  method secuenciaArealizar() {
  if (secuencias.size() < nivel) {
    secuencias.add(opciones.randomized().first())
    return self.secuenciaArealizar()  
  }
  return secuencias
}
  
  method subirDeNivel() {
    nivel += 1
    sucuenciasJugador.clear()
  }
  
  method addSecuenciaJugador(unColor) {
    if (wollokDice.flechas()) {
      const inputSound = new InputSound()
      self.removeImages([tuTurno])
      self.agregarColorYMostrar(unColor)
      sonido.ejecutar(inputSound)
      puntos.sumarPuntaje(1)
      if (self.esJugadaPerdedora()) {
        if (sonido.enEjecucion(inputSound)) sonido.detener(inputSound)
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
    unColor.mostraryOcultar()
    sucuenciasJugador.add(unColor)
  }
  
  method esJugadaPerdedora() = secuencias.take(
    sucuenciasJugador.size()
  ) != sucuenciasJugador
  
  method perder() {
    wollokDice.ocultarFlechas()
    game.addVisual(perdiste)
    // agrego 
    wollokDice.perdio()
  }
  
  method ultimaJugada() = sucuenciasJugador.size() == secuencias.size()
  
  method reiniciar() {
    if (wollokDice.reiniciar()) {
      //sonido.ejecutar(wollokDice.musicaMenu)
      nivel = 1
      secuencias.clear()
      sucuenciasJugador.clear()
      puntos.resetearPuntuacion()
      self.removeImages([perdiste, sinColores, tuTurno])
      puntos.removeVisual()
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
