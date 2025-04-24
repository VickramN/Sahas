extends ParallaxBackground


var scrolling_speed = 25

func _process(delta: float):
	scroll_offset.x -= scrolling_speed * delta
