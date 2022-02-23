import 'dart:core';

class Animal {
	late String _specie;
	late String _name;

	Animal() {

	}
	
	set specie(String _specie) {
		this._specie = _specie;
	}
	
	String get specie {
		return this._specie;
	}
	
	set name(String _name) {
		this._name = _name;
	}
	
	String get name {
		return this._name;
	}
}