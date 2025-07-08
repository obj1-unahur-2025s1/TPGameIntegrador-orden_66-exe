import interfaz.*

object paleta {
  const property amarillo = "FFE81F"
}

object tuNivel {
  method position() = game.at(3, 13)
  
  //cambiar a imagen
  method text() = "Secuencia: " + interfaz.nivel()
  
  method textColor() = paleta.amarillo()
}
