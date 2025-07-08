


class Numero{
     
    var property position = game.at(0, 0)
    var numero = 0
    var image = "0.png"

    method cambiarNumero(unNumero){
        numero = unNumero
    }    

    method image() = ""+ numero + ".png"

    method numero(){
        return numero
    }

    method reubicar(posX,posY){
        position = game.at(posX,posY)
    }
    
}

object puntos{      
    const property puntuacion = [new Numero(),new Numero(),new Numero(),new Numero()]
    var numero = 0

    method addVisual(){
     puntuacion.forEach({v => game.addVisual(v)})
    }

    method numero(){
        return numero
    }

    method removeVisual(){
    puntuacion.forEach({v => game.removeVisual(v)})
    }

    method resetearPuntuacion(){
        numero = 0
        puntuacion.forEach({p => p.cambiarNumero(0)})        
    }

    method ubicar(){
        puntuacion.get(0).reubicar(15,0)
        puntuacion.get(1).reubicar(14,0)
        puntuacion.get(2).reubicar(13,0)
        puntuacion.get(3).reubicar(12,0)
        
    }

    
    method sumarPuntaje(unNumero){
        numero = numero + unNumero        
        puntuacion.get(0).cambiarNumero(numero % 10)
        self.sumarDecimal()
        self.sumarCentena()
        self.sumarUnidadMil()             
    }
    method sumarDecimal(){
        const decimal = ((numero/10).truncate(0))%10
        puntuacion.get(1).cambiarNumero(decimal)       
    }

    method sumarCentena(){
        const centena = ((numero/100).truncate(0)%10)
        puntuacion.get(2).cambiarNumero(centena)        
    }

    method sumarUnidadMil(){
        const unidadMil = ((numero/1000).truncate(0)%10)
        puntuacion.get(3).cambiarNumero(unidadMil)    
    }
}