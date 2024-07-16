package hxdraw;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();
		Lib.current.addChild(new FlxGame(0, 0, MainState, 240, 240, true, false));
		FlxG.autoPause = false;
	}
}
