import cosas.* 
import cuentas.*

object casaDePepeYJulian {
	const property cosas = []

	//Las cosas que se compran

	//ejecutamos esto primero xq es lo que puede tirar excepción. sino, podríamos causar que se modifique
	//el estado cuando recibimos una excepción, lo cual NO debe pasar. En los casos en que recibimos
	//una excepción, todo debe quedar igual a como estaba antes de recibirla. Esto lo logramos ejecutando
	//primero lo que pueda tirar excepción.
	//No nos enfocamos en intentar hacer algo para arreglar la excepción, sino cuidarnos de que el estado 
	//quede como estaba inicialmente
	method comprar(cosa) {
		self.extraer(cosa.precio()) //PUEDE TIRAR EXCEPCIÓN
		cosas.add(cosa)
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

	//yo lo estaba haciendo de esta forma: la cuenta de banco de Pepe y Julián era un objeto que tenía como atributo el tipo de cuenta
	//que tenía, pero tmb tenía atributo saldo. Al depositar, se le mandaba mensaje al tipo de cuenta pasándole una cantidad y self (o sea,
	//la cuenta). Este método del tipo de cuenta ejecutaba el setter del saldo de la cuenta (para eso le pasamos la cuenta), al cual
	//le asignaba cuenta.saldo() + cantidad (- gastoExtra si había).
	//Esto funcionaba bien con cuenta corriente y cuenta con gastos, pero ya no tenía sentido con la cuenta combinada, la cual requiere
	//tener 2 cuentas, y, por lo tanto, 2 saldos (mientras que en la cuenta de pepe y julian tenemos UN saldo).
	//por tanto, supongo que esta opción es la adecuada (aunque si no estuviera lo de la cuenta combinada, yo creo que tiene más
	//sentido de la forma anterior, porque si hubiera 2 casas que quieran usar cuentas bancarias no se podría porque chocharían entre
	//ellas. Me parece más lógico separar a las cuentas de los tipos de cuenta).

	var property cuenta = cuentaConGastos

    method saldo() {
        return cuenta.saldo()
    }

    method depositar(cantidad) {
        cuenta.depositar(cantidad)
    }

    method extraer(cantidad) {
        cuenta.extraer(cantidad)
    }

}
