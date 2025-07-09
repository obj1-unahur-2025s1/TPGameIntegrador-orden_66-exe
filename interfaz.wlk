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
  const puntuaciones = [] //lista de puntaje
  
  method nivel() = nivel
  
  method opciones() = opciones
  
  method setDificultad(unaDificultad) {
    dificultad = unaDificultad
  }
  
  method prepararNivelInicial() {
    nivel = if (dificultad == "dificil") 4 else 1
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
      if (self.esJugadaPerdedora()) {
        if (sonido.enEjecucion(inputSound)) sonido.detener(inputSound)
        self.perder()
      } else {
        puntos.sumarPuntaje(1)
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
    if (self.esHighScore()) self.mostrarPantallaHightScore()
    else self.mostrarPantallaPerdio()
  }
  
  method esHighScore() = puntuaciones.isEmpty() || self.esMayorPuntuacion()
  
  method esMayorPuntuacion() = puntuaciones.any(
    { p => p.total() < puntos.valor() }
  )
  
  method mostrarPantallaPerdio() {
    game.addVisual(perdiste)
    wollokDice.perdio()
  }
  
  method mostrarPantallaHightScore() {
    game.addVisual(highScoreImage)
    const puntuacion = new Puntaje()
    
    if (puntuaciones.size() == 0) {
      puntuacion.agregarUnaLetra(new Letra(letra = "c2"))
      puntuacion.agregarUnaLetra(new Letra(letra = "a2"))
      puntuacion.agregarUnaLetra(new Letra(letra = "r2"))
    } else {
      if (puntuaciones.size() == 1) {
        puntuacion.agregarUnaLetra(new Letra(letra = "r2"))
        puntuacion.agregarUnaLetra(new Letra(letra = "a2"))
        puntuacion.agregarUnaLetra(new Letra(letra = "f2"))
      } else {
        puntuacion.agregarUnaLetra(new Letra(letra = "c2"))
        puntuacion.agregarUnaLetra(new Letra(letra = "e2"))
        puntuacion.agregarUnaLetra(new Letra(letra = "l2"))
      }
    }
    
    puntuacion.agregarUnPunto(
      new Numero(numero = puntos.puntuacion().get(1).numero())
    )
    puntuacion.agregarUnPunto(
      new Numero(numero = puntos.puntuacion().get(0).numero())
    )
    
    puntuaciones.add(puntuacion)
    puntuaciones.sortBy({ p, p1 => p.total() > p1.total() })
    const puntuacionesValidas = puntuaciones.take(3)
    puntuaciones.clear()
    puntuaciones.addAll(puntuacionesValidas)
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
      self.removeImages(
        [perdiste, sinColores, tuTurno, highScoreImage, highScoreLista]
      )
      self.ocultarTodoHighScore()
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
  
  method mostrarHighScore() {
    game.removeVisual(highScoreImage)
    game.removeVisual(fondoBase)
    if (!game.hasVisual(highScoreLista)) game.addVisual(highScoreLista)
    
    var posicionY = 13
    puntuaciones.forEach(
      { p =>
        var posicionInicialX = 6
        p.nombre().forEach(
          { l =>
            l.reubicar(posicionInicialX, posicionY)
            game.addVisual(l)
            posicionInicialX += 1
          }
        )
        
        var posicionNumeroX = 12
        p.score().forEach(
          { n =>
            n.reubicar(posicionNumeroX, posicionY)
            posicionNumeroX += 1
            return game.addVisual(n)
          }
        )
        
        posicionY -= 3
      }
    )
  }
  
  method ocultarTodoHighScore() {
    puntuaciones.forEach(
      { p =>
        p.nombre().forEach({ l => game.removeVisual(l) })
        return p.score().forEach({ n => game.removeVisual(n) })
      }
    )
    game.removeVisual(highScoreLista)
  }
}
