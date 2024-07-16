package hxdraw.util.math;

class Region {
	public final x1:Float;
	public final x2:Float;
	public final y1:Float;
	public final y2:Float;

	public function new(x1:Float, y1:Float, x2:Float, y2:Float) {
		this.x1 = x1;
		this.x2 = x2;
		this.y1 = y1;
		this.y2 = y2;
	}

	public function contains(x:Float, y:Float) {
		if (x >= this.x1 && x <= this.x2 && y >= this.y1 && y <= this.y2)
			return true;
		return false;
	}

	public function width() {
		return Math.abs(x1 - x2);
	}

	public function height() {
		return Math.abs(y1 - y2);
	}

	public function area() {
		return this.width() * this.height();
	}
}
