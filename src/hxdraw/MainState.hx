package hxdraw;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import hxdraw.util.math.Region;

class MainState extends FlxState {
	private static var canvas:Region;

	override public function create() {
		super.create();

		canvas = new Region(0, 0, 640, 480);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		if (FlxG.mouse.pressed && canvas.contains(FlxG.mouse.x, FlxG.mouse.y)) {
			var tr = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y);
			tr.makeGraphic(2, 2, FlxColor.WHITE);
			add(tr);
		}

		if (FlxG.keys.justPressed.SPACE) {
			FlxG.switchState(new MainState());
		}
	}
}
