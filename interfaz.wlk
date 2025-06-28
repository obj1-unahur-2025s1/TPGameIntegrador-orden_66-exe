import colores.*
import wollokDice.*

object interfaz {
  var nivel = 1
  const opciones = [rojo, azul, verde, amarillo]
  const property secuencias = []
  const sucuenciasJugador = []
  
  method nivel() = nivel
  
  method opciones() = opciones
  
  method secuenciaArealizar2() {
    if (nivel != secuencias.size()) {
      if (nivel >= opciones.size()) opciones.add(
          opciones.asList().randomized().first()
        )
      
      const nuevoDesafio = opciones.randomized()
      secuencias.add(nuevoDesafio.first())
    }
    return secuencias
  }
  
  method secuenciaArealizar() {
    if (secuencias.size() < nivel) secuencias.add(opciones.randomized().first())
    return secuencias
  }
  
  method subirDeNivel() {
    nivel += 1
    sucuenciasJugador.clear()
  }
  
  method addSecuenciaJugador(unColor) {
    //game.schedule(1000, { unColor.mostraryOcultar() })
    sucuenciasJugador.add(unColor)
    
    if (secuencias.take(sucuenciasJugador.size()) != sucuenciasJugador) {
      game.clear()
      //game.removeVisual(fondoBase)
      game.addVisual(perdiste)
      keyboard.enter().onPressDo({ self.reiniciar() })
    }
    
    if (sucuenciasJugador == secuencias) {
      self.subirDeNivel()
      wollokDice.continuarGame()
    }
  }
  
  method reiniciar() {
    nivel = 1
    secuencias.clear()
    sucuenciasJugador.clear()
    game.removeVisual(perdiste)
    game.addVisual(fondoInicio)
    keyboard.enter().onPressDo({ wollokDice.iniciarGame() })
  }
}

object perdiste {
  method text() = "PERDISTE, presiona Enter para ir al menu"
  
  method position() = game.center()
}
