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
  var ingresarNombre = false
  var cursor = 1
  var property puntuacion = new Puntaje()
  const property pl1 = 8
  const property pl2 = 10
  const property pl3 = 12
  
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
        puntos.sumarPuntaje(self.puntajeASumar())
        if (self.ultimaJugada()) {
          self.subirDeNivel()
          game.schedule(500, { wollokDice.continuarGame() })
        }
      }
    }
  }
  
  method puntajeASumar() = if (dificultad == "dificil") 1 else 2
  
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
    wollokDice.perdio()
  }
  
  method esHighScore() = (puntos.valor() > 0) && ((puntuaciones.size() < 4) || self.esMayorPuntuacion())
  
  method esMayorPuntuacion() = puntuaciones.any(
    { p => p.total() < puntos.valor() }
  )
  
  method mostrarPantallaPerdio() {
    game.addVisual(perdiste)
  }
  
  method mostrarPantallaHightScore() {
    ingresarNombre = true
    game.addVisual(highScoreImage)
    puntuacion = new Puntaje()
    game.addVisual(puntuacion.l1())
    game.addVisual(puntuacion.l2())
    game.addVisual(puntuacion.l3())
    objCursor.titilar()
    game.addVisual(space)
  }
  
  method cambiarUnaLetra(operacion) {
    if (ingresarNombre) {
      if (operacion == "restar") {
        if (cursor == 1) {
          var nuevaLetra = puntuacion.l1().valor() - 1
          if (nuevaLetra < 0) {
            nuevaLetra = 25
          }
          
          puntuacion.l1().cambiarLetra(nuevaLetra)
        }
        
        if (cursor == 2) {
          var nuevaLetra = puntuacion.l2().valor() - 1
          if (nuevaLetra < 0) {
            nuevaLetra = 25
          }
          
          puntuacion.l2().cambiarLetra(nuevaLetra)
        }
        
        if (cursor == 3) {
          var nuevaLetra = puntuacion.l3().valor() - 1
          if (nuevaLetra < 0) {
            nuevaLetra = 25
          }
          
          puntuacion.l3().cambiarLetra(nuevaLetra)
        }
      } else {
        if (cursor == 1) {
          var nuevaLetra = puntuacion.l1().valor() + 1
          if (nuevaLetra > 25) {
            nuevaLetra = 1
          }
          
          puntuacion.l1().cambiarLetra(nuevaLetra)
        }
        
        if (cursor == 2) {
          var nuevaLetra = puntuacion.l2().valor() + 1
          if (nuevaLetra > 25) {
            nuevaLetra = 1
          }
          
          puntuacion.l2().cambiarLetra(nuevaLetra)
        }
        
        if (cursor == 3) {
          var nuevaLetra = puntuacion.l3().valor() + 1
          if (nuevaLetra > 25) {
            nuevaLetra = 1
          }
          
          puntuacion.l3().cambiarLetra(nuevaLetra)
        }
      }
    }
  }
  
  method cambiarCursor(operacion) {
    if (ingresarNombre) {
      game.removeTickEvent("cursor")
      objCursor.ocultar()
      
      if (operacion == "izq") {
        if (cursor == 1) {
          cursor = 3
          objCursor.reubicar(pl3, 4.5)
          objCursor.titilar()
        } else {
          if (cursor == 2) {
            cursor = 1
            objCursor.reubicar(pl1, 4.5)
            objCursor.titilar()
          } else {
            cursor = 2
            objCursor.reubicar(pl2, 4.5)
            objCursor.titilar()
          }
        }
      } else {
        if (cursor == 1) {
          cursor = 2
          objCursor.reubicar(pl2, 4.5)
          objCursor.titilar()
        } else {
          if (cursor == 2) {
            cursor = 3
            objCursor.reubicar(pl3, 4.5)
            objCursor.titilar()
          } else {
            cursor = 1
            objCursor.reubicar(pl1, 4.5)
            objCursor.titilar()
          }
        }
      }
    }
  }
  
  method despuesDelNombre() {
    if (ingresarNombre) {
      ingresarNombre = false
      game.removeVisual(space)
      game.removeTickEvent("cursor")
      cursor = 1
      objCursor.reubicar(pl1, 4.5)
      objCursor.ocultar()
      
      puntuacion.n1().cambiarNumero(puntos.puntuacion().get(3).numero())
      puntuacion.n2().cambiarNumero(puntos.puntuacion().get(2).numero())
      puntuacion.n3().cambiarNumero(puntos.puntuacion().get(1).numero())
      puntuacion.n4().cambiarNumero(puntos.puntuacion().get(0).numero())
      
      puntuaciones.add(puntuacion)
      puntuaciones.sortBy({ p, p1 => p.total() > p1.total() })
      if (puntuaciones.size() > 3) {
        const puntuacionesValidas = puntuaciones.take(3)
        puntuaciones.clear()
        puntuaciones.addAll(puntuacionesValidas)
      }
      
      self.reiniciar()
      self.mostrarHighScore()
    }
  }
  
  method ultimaJugada() = sucuenciasJugador.size() == secuencias.size()
  
  method reiniciar() {
    if (wollokDice.reiniciar()) {
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
      wollokDice.startGame(false)
      game.removeVisual(fondoInicio)
      game.addVisual(intrucciones)
    }
  }
  
  method mostrarMenu() {
    if (!wollokDice.enJuego()) {
      if (game.hasVisual(intrucciones)) game.removeVisual(intrucciones)
      self.ocultarTodoHighScore()
      if (!game.hasVisual(fondoInicio)) game.addVisual(fondoInicio)
    }
  }
  
  method mostrarHighScore() {
    wollokDice.startGame(false)
    if ((!wollokDice.enJuego()) || wollokDice.reiniciar()) {
      game.removeVisual(highScoreImage)
      game.removeVisual(fondoBase)
      if (!game.hasVisual(highScoreLista)) game.addVisual(highScoreLista)
      if (puntuaciones.size() == 0) {
        if (not game.hasVisual(sinHighScore)) game.addVisual(sinHighScore)
      } else {
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
            
            var posicionNumeroX = 10
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
    }
    if (!wollokDice.enJuego()) game.addVisual(volver)
    else game.addVisual(volverR)
  }
  
  method ocultarTodoHighScore() {
    if (game.hasVisual(volverR)) game.removeVisual(volverR)
    if (game.hasVisual(volver)) game.removeVisual(volver)
    if (game.hasVisual(sinHighScore)) game.removeVisual(sinHighScore)
    puntuaciones.forEach(
      { p =>
        p.nombre().forEach({ l => if (game.hasVisual(l)) game.removeVisual(l) })
        return p.score().forEach(
          { n => if (game.hasVisual(n)) game.removeVisual(n) }
        )
      }
    )
    if (game.hasVisual(highScoreLista)) game.removeVisual(highScoreLista)
  }
}
