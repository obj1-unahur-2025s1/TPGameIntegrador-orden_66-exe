
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
  sucuenciasJugador.add(unColor)
  unColor.mostraryOcultar()
  
  
  if (secuencias.take(sucuenciasJugador.size()) != sucuenciasJugador) {
    tuTurno.ocultar()

    game.addVisual(perdiste)
  } else if (sucuenciasJugador.size() == secuencias.size()) {
    game.schedule(400, { tuTurno.ocultar() })
    self.subirDeNivel()
    game.schedule(1000, { wollokDice.continuarGame() })
  }
}


method reiniciar() {
  nivel = 1
  secuencias.clear()
  sucuenciasJugador.clear()
  game.removeVisual(perdiste)
  wollokDice.iniciarGame()
}
}
