import colores.*

object interfaz {
  var nivel = 1
  const opciones = [rojo, azul, verde, amarillo]
  const property secuencias = []
  const sucuenciasJugador = []
  
  //[azul, verde, rojo]
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
    
    
    
    
    
    // cambiar las imaghenes para que se vea q la secuencia
    return secuencias
  }
  
  method subirDeNivel() {
    nivel += 1
    sucuenciasJugador.clear()
  }
  
  method addSecuenciaJugador(unColor) {
    sucuenciasJugador.add(unColor)
    
    
    
    
    
    // cambiar las imaghenes para que se vea q flecha hizo click
    if (secuencias.take(sucuenciasJugador.size()) != sucuenciasJugador) {
      self.reiniciar()
      self.error("Perdiste")
    }
    
    if (sucuenciasJugador.size() == secuencias.size()) self.subirDeNivel()
  }
  
  method reiniciar() {
    nivel = 1
    secuencias.clear()
    sucuenciasJugador.clear()
  }
  
  method init() {
    keyboard.w().onPressDo({ self.addSecuenciaJugador(rojo) })
    keyboard.s().onPressDo({ self.addSecuenciaJugador(azul) })
    keyboard.d().onPressDo({ self.addSecuenciaJugador(verde) })
    keyboard.a().onPressDo({ self.addSecuenciaJugador(amarillo) })
    // keyboard.m().onPressDo({ self.openMenu()})
  }
}
