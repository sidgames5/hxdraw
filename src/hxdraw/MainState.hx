package hxdraw;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import hxdraw.util.math.Region;

class MainState extends FlxState {
	private static var canvas:Region;

	private static var color:FlxColor;

	private static var colorSelectorWhite:FlxSprite;
	private static var colorSelectorRed:FlxSprite;
	private static var colorSelectorGreen:FlxSprite;
	private static var colorSelectorBlue:FlxSprite;

	override public function create() {
		super.create();

		canvas = new Region(32, 0, 640, 480);

		colorSelectorWhite = new FlxSprite(0, canvas.x1 * 0);
		colorSelectorWhite.makeGraphic(cast canvas.x1, cast canvas.x1, FlxColor.WHITE);
		add(colorSelectorWhite);
		colorSelectorRed = new FlxSprite(0, canvas.x1 * 1);
		colorSelectorRed.makeGraphic(cast canvas.x1, cast canvas.x1, FlxColor.RED);
		add(colorSelectorRed);
		colorSelectorGreen = new FlxSprite(0, canvas.x1 * 2);
		colorSelectorGreen.makeGraphic(cast canvas.x1, cast canvas.x1, FlxColor.GREEN);
		add(colorSelectorGreen);
		colorSelectorBlue = new FlxSprite(0, canvas.x1 * 3);
		colorSelectorBlue.makeGraphic(cast canvas.x1, cast canvas.x1, FlxColor.BLUE);
		add(colorSelectorBlue);

		color = FlxColor.WHITE;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		if (FlxG.mouse.pressed && canvas.contains(FlxG.mouse.x, FlxG.mouse.y)) {
			var tr = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y);
			tr.makeGraphic(2, 2, color);
			add(tr);
		}

		if (FlxG.keys.justPressed.SPACE) {
			FlxG.switchState(new MainState());
		}

		if (FlxG.mouse.justPressed) {
			if (FlxG.mouse.overlaps(colorSelectorWhite))
				color = FlxColor.WHITE;
			if (FlxG.mouse.overlaps(colorSelectorRed))
				color = FlxColor.RED;
			if (FlxG.mouse.overlaps(colorSelectorGreen))
				color = FlxColor.GREEN;
			if (FlxG.mouse.overlaps(colorSelectorBlue))
				color = FlxColor.BLUE;
		}
	}
}
