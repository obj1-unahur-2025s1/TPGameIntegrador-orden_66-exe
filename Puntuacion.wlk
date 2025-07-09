class Numero {
  var property position = game.at(0, 0)
  var numero = 0
  
  method cambiarNumero(unNumero) {
    numero = unNumero
  }
  
  method image() = ("" + numero) + ".png"
  
  method numero() = numero
  
  method reubicar(posX, posY) {
    position = game.at(posX, posY)
  }
}

class Letra {
  var property position = game.at(0, 0)
  const letra
  
  method image() = letra + ".png"
  
  method valor() = letra
  
  method reubicar(posX, posY) {
    position = game.at(posX, posY)
  }
}

class Puntaje {
  const score = []
  const nombre = []
  
  method agregarUnaLetra(unaLetra) {
    nombre.add(unaLetra)
  }
  
  method agregarUnPunto(unPunto) {
    score.add(unPunto)
  }
  
  method score() = score
  
  method nombre() = nombre
  
  method total() = score.sum({ n => n.numero() })
}

object puntos {
  const property puntuacion = [new Numero(), new Numero()]
  var numero = 0
  
  method addVisual() {
    puntuacion.forEach({ v => game.addVisual(v) })
  }
  
  method numero() = numero
  
  method removeVisual() {
    puntuacion.forEach({ v => game.removeVisual(v) })
  }
  
  method resetearPuntuacion() {
    numero = 0
    puntuacion.forEach({ p => p.cambiarNumero(0) })
  }
  
  method ubicar() {
    puntuacion.get(0).reubicar(15, 0)
    puntuacion.get(1).reubicar(14, 0)
  }
  
  method sumarPuntaje(unNumero) {
    numero += unNumero
    puntuacion.get(0).cambiarNumero(numero % 10)
    self.sumarDecimal()
  }
  
  method sumarDecimal() {
    const decimal = (numero / 10).truncate(0) % 10
    puntuacion.get(1).cambiarNumero(decimal)
  }
  
  method valor() = puntuacion.get(0).numero() + (puntuacion.get(
    1
  ).numero() * 10)
  
  method puntuacion() = puntuacion
}
