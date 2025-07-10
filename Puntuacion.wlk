import interfaz.*

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
  var numero = 0
  
  method image() = ("letra_" + numero) + ".png"
  
  method valor() = numero
  
  method reubicar(posX, posY) {
    position = game.at(posX, posY)
  }
  
  method cambiarLetra(unaLetra) {
    numero = unaLetra
  }
}

class Puntaje {
  const score = [new Numero(), new Numero(), new Numero(), new Numero()]
  const nombre = [
    new Letra(numero = 0, position = game.at(interfaz.pl1(), 5)),
    new Letra(numero = 0, position = game.at(interfaz.pl2(), 5)),
    new Letra(numero = 0, position = game.at(interfaz.pl3(), 5))
  ]
  
  method agregarUnaLetra(unaLetra) {
    nombre.add(unaLetra)
  }
  
  method agregarUnPunto(unPunto) {
    score.add(unPunto)
  }
  
  method nombre() = nombre
  
  method score() = score
  
  method l1() = nombre.get(0)
  
  method l2() = nombre.get(1)
  
  method l3() = nombre.get(2)
  
  method n1() = score.get(0)
  
  method n2() = score.get(1)
  
  method n3() = score.get(2)
  
  method n4() = score.get(3)
  
  method total() = score.sum({ n => n.numero() })
}

object puntos {
  const property puntuacion = [
    new Numero(),
    new Numero(),
    new Numero(),
    new Numero()
  ]
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
    puntuacion.get(2).reubicar(13, 0)
    puntuacion.get(3).reubicar(12, 0)
  }
  
  method sumarPuntaje(unNumero) {
    numero += unNumero
    puntuacion.get(0).cambiarNumero(numero % 10)
    self.sumarDecimal()
    self.sumarCentena()
    self.sumarUnidadMil()
  }
  
  method sumarDecimal() {
    const decimal = (numero / 10).truncate(0) % 10
    puntuacion.get(1).cambiarNumero(decimal)
  }
  
  method sumarCentena() {
    const centena = (numero / 100).truncate(0) % 10
    puntuacion.get(2).cambiarNumero(centena)
  }
  
  method sumarUnidadMil() {
    const unidadMil = (numero / 1000).truncate(0) % 10
    puntuacion.get(3).cambiarNumero(unidadMil)
  }
  
  method valor() = puntuacion.get(0).numero() + (puntuacion.get(
    1
  ).numero() * 10)
  
  method puntuacion() = puntuacion
}
