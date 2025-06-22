import colores.*
import wollokDice.*

object interfaz {
  var nivel = 1
  const opciones = [rojo, azul, verde, amarillo]
  const property secuencias = []
  const sucuenciasJugador = []
  
  method nivel() = nivel
  
  method opciones() = opciones
  
  method secuenciaArealizar() {
    if (nivel != secuencias.size()) {
      if (nivel >= opciones.size()) opciones.add(
          opciones.asList().randomized().first()
        )
      
      const nuevoDesafio = opciones.randomized()
      secuencias.add(nuevoDesafio.first())
    }
    return secuencias
  }
  
  method subirDeNivel() {
    nivel += 1
    sucuenciasJugador.clear()
  }
  
  method addSecuenciaJugador(unColor) {
    sucuenciasJugador.add(unColor)
    
    if (secuencias.take(sucuenciasJugador.size()) != sucuenciasJugador) {
      game.clear()
      game.addVisual(perdiste)
      keyboard.enter().onPressDo({ self.reiniciar() })
    }
    
    if (sucuenciasJugador == secuencias) {
      self.subirDeNivel()
      wollokDice.iniciarGame()
    }
  }
  
  method reiniciar() {
    nivel = 1
    secuencias.clear()
    sucuenciasJugador.clear()
    wollokDice.iniciarGame()
  }
}

object perdiste {
  method text() = "PERDISTE"
  
  method position() = game.center()
}
