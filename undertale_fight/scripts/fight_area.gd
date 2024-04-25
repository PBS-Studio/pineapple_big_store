extends SubViewportContainer

@export var area_size: Vector2:
	set(value):
		delta_size = value - current_size
		area_size = value

@export var duration: float
@export var color: Color
@export var thickness: float = 1

var current_size: Vector2
var delta_size: Vector2=Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	current_size = area_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if (area_size - current_size).dot(delta_size) < 0:
		return
	current_size += delta / duration * delta_size
	queue_redraw()


func _draw():
	var width = current_size.x / 2
	var height = current_size.y / 2
	
	$SubViewport/Boundary/WorldBorder/Right.position.x = width;
	$SubViewport/Boundary/WorldBorder/Left.position.x = -width;
	$SubViewport/Boundary/WorldBorder/Top.position.y = -height;
	$SubViewport/Boundary/WorldBorder/Bottom.position.y = height;
	
	
	
	width -= thickness / 2
	height -= thickness / 2
	
	var coords: PackedVector2Array = [
		Vector2(width - position.x, height - position.y),
		Vector2(- width - position.x, height - position.y),
		Vector2(- width - position.x, - height - position.y),
		Vector2(width - position.x, - height - position.y),
		Vector2(width - position.x, height - position.y),
	]
	
	draw_polyline(coords, color, thickness)
