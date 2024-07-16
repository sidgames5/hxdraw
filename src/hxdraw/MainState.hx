package hxdraw;

import lime.ui.FileDialog;
import sys.io.File;
import lime.graphics.Image;
import lime.math.Rectangle;
import openfl.display.PNGEncoderOptions;
import openfl.utils.ByteArray;
import openfl.display.BitmapData;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import hxdraw.util.math.Region;

using StringTools;

class MainState extends FlxState {
	private var canvas:Region;

	private var color:FlxColor;
	private var size:Int = 2;

	private var colorSelectorWhite:FlxSprite;
	private var colorSelectorRed:FlxSprite;
	private var colorSelectorGreen:FlxSprite;
	private var colorSelectorBlue:FlxSprite;
	private var cursorSizeUp:FlxText;
	private var cursorSizeDown:FlxText;
	private var cursorSize:FlxText;

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

		cursorSizeUp = new FlxText(0, canvas.x1 * 5, 0, "+", 36);
		add(cursorSizeUp);
		cursorSize = new FlxText(0, canvas.x1 * 6, 0, '$size', 36);
		add(cursorSize);
		cursorSizeDown = new FlxText(0, canvas.x1 * 7, 0, "-", 36);
		add(cursorSizeDown);

		color = FlxColor.WHITE;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		if (FlxG.mouse.pressed && canvas.contains(FlxG.mouse.x, FlxG.mouse.y)) {
			var tr = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y);
			tr.makeGraphic(size, size, color);
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

		cursorSize.text = '$size';
		if (FlxG.mouse.justPressed) {
			if (FlxG.mouse.overlaps(cursorSizeUp))
				size += 1;
			if (FlxG.mouse.overlaps(cursorSizeDown))
				size -= 1;
		}
		if (size <= 0)
			size = 1;

		if (FlxG.keys.pressed.CONTROL && FlxG.keys.justPressed.S) {
			var rect:Null<Rectangle> = new Rectangle(canvas.x1, canvas.y1, canvas.width(), canvas.height());
			var image:Image = FlxG.stage.window.readPixels(rect);
			var bitmapData = new BitmapData(cast canvas.width(), cast canvas.height(), true, 0);
			bitmapData.setPixels(bitmapData.rect, ByteArray.fromBytes(image.data.toBytes()));
			var bytes = bitmapData.encode(bitmapData.rect, new PNGEncoderOptions());
			var dt = Date.now().toString();
			dt = dt.replace(":", "");
			dt = dt.replace("-", "");
			dt = dt.replace(" ", "_");
			var fn = 'hxdraw_$dt.png';
			var path = "";
			var saveDialog = new FileDialog();
			saveDialog.save(bytes, "png", fn, "Save Image");
			// File.saveBytes(path, bytes);
		}
	}
}
