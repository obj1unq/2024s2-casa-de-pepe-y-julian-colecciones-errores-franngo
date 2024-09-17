import cosas.* 
import cuentas.*

object casaDePepeYJulian {
	const property cosas = []

	//Las cosas que se compran

	method comprar(cosa) {
		cosas.add(cosa)
		cuenta.extraer(cosa.precio())
	}

	method cantidadDeCosasCompradas() {
		return cosas.size()
	}

	method tieneAlgun(categoria) {
		return self.categoriaDeCosas().contains(categoria) //era más sencilo con any
	}

	//auxiliar
	method categoriaDeCosas()  {
		return cosas.map({cosa => cosa.categoria()})
	}

	method vieneDeComprar(categoria) {
		return !cosas.isEmpty() && cosas.last().categoria() == categoria
	}

	method esDerrochona() {
		return  self.totalValorDeCosas() >= 9000
	}

	//auxiliar
	method totalValorDeCosas() {
		return cosas.sum({cosa => cosa.precio()})
	}

	method compraMasCara() {
		return cosas.max({cosa => cosa.precio()}) //el máximo se determina por cosa.precio(), pero lo que se guarda
												  //es la cosa
	}

	method comprados(categoria) {
		return cosas.filter({cosa => cosa.categoria()==categoria})
	}

	//para evitar el warning, deberíamos hacerlo con polimorfismo, creando el método esComestible() para cada una
	//de las categorías, de modo que podemos preguntar cosa.categoria().esComestible() en vez de == comida)
	//la actual igual está BIEN
	method esMalaEpoca() {
		return cosas.all({cosa => cosa.categoria()==comida}) 
															 
	}

	method queFaltaComprar(lista) {
		return lista.filter({cosa => !cosas.contains(cosa)})
	}

	method faltaComida() {
		return self.categoriaDeCosas().filter({categoria => categoria==comida}).size()<2
		//return cosas.count(cosa => cosa.categoria()==comida) 
		//el count suma uno en un contador por cada vez que da true la condición indicada. devuelve el contador
	}

	method categoriasCompradas() {
		return self.categoriaDeCosas().asSet() //transformo lista de categorias en set. así elimino repes.
											   //y solo quedan las categorías que se tengan UNA sola vez
	}

	//EL MAP SIEMPRE DEVUELVE LISTA EN WOLLOK (en otras tecnologías devuelve el tipo de colec empleada como parámetro)

	//Cuentas bancarias

	var property cuenta = cuentaConGastos

    method sueldo() {
        cuenta.saldo()
    }

    method depositar(cantidad) {
        cuenta.depositar(cantidad)
    }

    method extraer(cantidad) {
        cuenta.extraer(cantidad)
    }

}
