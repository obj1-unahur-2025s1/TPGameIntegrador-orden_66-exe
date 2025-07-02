import colores.*
import wollokDice.*
import wollok.game.*

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
      sucuenciasJugador.add(unColor)
      unColor.mostraryOcultar()
      
      if (secuencias.take(sucuenciasJugador.size()) != sucuenciasJugador) {
        wollokDice.ocultarFlechas()
        game.addVisual(perdiste)
      } else {
        if (sucuenciasJugador.size() == secuencias.size()) {
          self.subirDeNivel()
          game.schedule(1000, { wollokDice.continuarGame() })
        }
      }
    }
  }
  
  method reiniciar() {
    nivel = 1
    secuencias.clear()
    sucuenciasJugador.clear()
    game.removeVisual(perdiste)
    wollokDice.continuarGame()
  }
}

object paleta {
  const property amarillo = "FFE81F"
}

object tuTurnoVersionTexto {
  method position() = game.at(15, 13)
  
  method text() = "¡Tu turno!"
  
  method textColor() = paleta.amarillo()
}

object tuNivel {
  method position() = game.at(4, 13)
  
  method text() = "Nivel: " + interfaz.nivel()
  
  method textColor() = paleta.amarillo()
}
