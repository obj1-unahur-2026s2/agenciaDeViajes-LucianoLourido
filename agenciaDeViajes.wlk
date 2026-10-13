class Agencia{
    const duracionEnDias
    const precioBase = 0
    var coordinador
    var costoTotal  
    const beneficios = []

    method precioBase() = precioBase
    method costoBeneficios()= beneficios.filter({b => b.estaVigente()}).sum({b => b.costo()})
    method costoTotal()= self.precioBase() + self.costoBeneficios()
    method duracionEnDias() = duracionEnDias
    method destino(unDestino) = "unDestino"
    method esPremium()
}

class ViajeNacional inherits Agencia{
    var provinciaDestino
    const actividad = []
    method agregarActividad(actividadAdd) {
      actividad.add(actividadAdd)
    } 
    override method esPremium() = self.duracionEnDias() > 10 and coordinador.esAltamenteCalificado(self)

}
class ViajeProvincial inherits ViajeNacional{
    const cantCiudadesVisitadas 
    method cantCiudadesVisitadas() = cantCiudadesVisitadas
    override method esPremium() = actividad.count({a => actividad.size() >= 4}) and self.cantCiudadesVisitadas() > 5 and beneficios.filter({b => b.estaVigente()}).min(3) 
    override method costoTotal() = super() * 1.05 
}
class ViajeInternacional inherits Agencia{
    var paisDestino
    var escala 
    var eslugarDeInteres = true
    method cantidadDeEscalas() =  escala
    method esLugarDeInteres() = eslugarDeInteres
    override method costoTotal() = super() * 1.20  
    override method esPremium() =  self.esLugarDeInteres() and self.duracionEnDias() > 20 and self.cantidadDeEscalas() == 0
}

class Coordinador{
    const roles = ["Guia","Asistente Logistico","Acompañante"]
    const cantViajes 
    var rolActual = "Guia"
    var estaMotivado = true
    var aniosDeExp = 0
    method cantViajesRealizados() = cantViajes
    method estaMotivado() = estaMotivado
    method aniosDeExp() =aniosDeExp     
    method CambiarRol(nuevoRol){
        if(roles.contains(nuevoRol)){
            rolActual = nuevoRol
        }
        else
            self.error("El rol pasado no existe") 
    } 
    method esAltamenteCalificado(coordinador) = self.cantViajesRealizados() > 20 and roles.cumpleCondicion(self) 
    
}
class Beneficio{
    const tipo = ["TrasladosPriv","AccesoAVip","SegurosAdic"]
    const costo 
    var vigente = true 
    method costo() = costo
    method estaVigente() = vigente
}
object guia {
    method cumpleCondicion(coordinador) = coordinador.estaMotivado()

}
class Asitente inherits Coordinador {
  method cumpleCondicion(coordinador) = coordinador.aniosDeExp() >= 3
}
class Acompañante inherits Coordinador {
  method cumpleCondicion(coordinador) = true
}
