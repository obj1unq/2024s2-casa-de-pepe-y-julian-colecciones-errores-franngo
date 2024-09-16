import cosas.* 

object casaDePepeYJulian {
	const property cosas = []

	//Las cosas que se compran

	method comprar(cosa) {
		cosas.add(cosa)
	}

	method cantidadDeCosasCompradas() {
		return cosas.size()
	}

	method tieneAlgun(categoria) {
		return self.categoriaDeCosas().contains(categoria)
	}

	//auxiliar
	method categoriaDeCosas()  {
		return cosas.map({cosa => cosa.categoria()})
	}

	method vieneDeComprar(categoria) {
		return cosas.last().categoria() == categoria
	}

	method esDerrochona() {
		return  self.totalValorDeCosas() >= 9000
	}

	//auxiliar
	method totalValorDeCosas() {
		return cosas.sum({cosa => cosa.precio()})
	}

	method compraMasCara() {
		return cosas.max({cosa => cosa.precio()})
	}

	method comprados(categoria) {
		return cosas.filter({cosa => cosa.categoria()==categoria})
	}

	method esMalaEpoca() {
		return cosas.all({cosa => cosa.categoria()==comida})
	}

	method queFaltaComprar(lista) {
		return lista.filter({cosa => !cosas.contains(cosa)})
	}

	method faltaComida() {
		return self.categoriaDeCosas().filter({categoria => categoria==comida}).size()<2
	}

	method categoriasCompradas() {
		return self.categoriaDeCosas().asSet() //transformo lista de categorias en set. así elimino repes.
											   //y solo quedan las categorías que se tengan UNA sola vez
	}

	//Cuentas bancarias

}
