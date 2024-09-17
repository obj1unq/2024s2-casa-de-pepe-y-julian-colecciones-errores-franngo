object cuentaCorriente {
    var property saldo = 0

    method depositar(cantidad) {
        saldo = saldo + cantidad.max(0) //el max 0 es por si se ingresa una cantidad negativa
    }

    method validarExtraccion(cantidad) {
        if (cantidad > saldo) { //tira error si el saldo es insuficiente. sino, no hace NADA
            self.error("El saldo actual de " + saldo + " pesos no es suficiente para realizar la extracción")
        }
    }

    method extraer(cantidad) {
        self.validarExtraccion(cantidad)
        saldo = saldo - cantidad.max(0)
    }

}

object cuentaConGastos {
    var property saldo = 0
    var property costoPorOperacion = 0

    method depositar(cantidad) {
        saldo = saldo + cantidad.max(0) - costoPorOperacion
    }

    method validarExtraccion(cantidad) {
        if(cantidad > saldo) {
            self.error("El saldo actual de " + saldo + " pesos no es suficiente para realizar la extracción")
        }
    }

    method extraer(cantidad) {
        self.validarExtraccion(cantidad)
        saldo = saldo - cantidad.max(0)
    }

}

object cuentaCombinada {
    var property cuentaPrimaria = cuentaCorriente
    var property cuentaSecundaria = cuentaConGastos

    method saldo() {
        return cuentaPrimaria.saldo() + cuentaSecundaria.saldo()
    }

    method depositar(cantidad) {
        cuentaPrimaria.depositar(cantidad)
    }

    //acá no hay método validar porque se va a encargar de la validación directamente la cuenta secundaria si no hay plata en la primaria
    method extraer(cantidad) {
        if(cuentaPrimaria.saldo()>=cantidad) {
            cuentaPrimaria.extraer(cantidad)
        } else {
            cuentaSecundaria.extraer(cantidad) //y si en la secundaria no hay suficiente, entonces falla/tira excepción
        }
    }
}