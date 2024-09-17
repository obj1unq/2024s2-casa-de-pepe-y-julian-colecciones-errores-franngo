object cuentaCorriente {
    var property saldo = 0

    method depositar(cantidad) {
        saldo= saldo + cantidad.max(0)
    }

    method extraer(cantidad) {
        saldo= saldo - cantidad.max(0)
    }

}

object cuentaConGastos {
    var property saldo = 0
    var property costoPorOperacion = 0

    method depositar(cantidad) {
        saldo = saldo + cantidad.max(0) - costoPorOperacion
    }

    method extraer(cantidad) {
        saldo = saldo - cantidad.max(0)
    }

}

object cuentaCombinada { //revisar
    var property cuentaPrimaria = cuentaCorriente
    var property cuentaSecundaria = cuentaConGastos

    method saldo() {
        return cuentaPrimaria.saldo() + cuentaSecundaria.saldo()
    }

    method depositar(cantidad) {
        cuentaPrimaria.depositar(cantidad)
    }

    method extraer(cantidad) {
        if(self.saldo()>=cantidad) {
            cuentaPrimaria.extraer(cantidad)
        } else {
            cuentaSecundaria.extraer(cantidad)
        }
    }
}