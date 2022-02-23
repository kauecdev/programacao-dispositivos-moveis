import 'dart:core';

import 'animais.dart';

class Bovine extends Animal {
	late double _milkProduction;

	Bovine() {

	}

	Bovine.cow() {
		this._milkProduction = 5;
	}

	Bovine.goat() {
		this._milkProduction = 3;
	}

	set milkProduction(double _milkProduction) {
		this._milkProduction = _milkProduction;
	}
	
	double get milkProduction {
		return this._milkProduction;
	}
}