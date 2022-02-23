import 'dart:core';

import 'animais.dart';

class Fish extends Animal {
	late int _depth;

	Fish() {

	}

	Fish.clownFish() {
		this._depth = 15;
	}

	Fish.pufferFish() {
		this._depth = 25;
	}

	set depth(int _depth) {
		this._depth = _depth;
	}
	
	int get depth {
		return this._depth;
	}
}