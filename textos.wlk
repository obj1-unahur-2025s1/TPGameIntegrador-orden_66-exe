import interfaz.*

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
