@tool
extends Node2D

@export var size: Vector2:
	set(value):
		delta_size = value - current_size
		size = value

@export var duration: float
@export var color: Color
@export var thickness: float

@export var left_boundary: CollisionShape2D
@export var right_boundary: CollisionShape2D
@export var top_boundary: CollisionShape2D
@export var bottom_boundary: CollisionShape2D


var current_size: Vector2
var delta_size: Vector2=Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	current_size = size



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if (current_size - size).length() < 10.0:
		return
	current_size += delta / duration * delta_size
	queue_redraw()


func _draw():
	var width = current_size.x / 2
	var height = current_size.y / 2
	var coords: PackedVector2Array = [
		Vector2(width, height),
		Vector2(- width, height),
		Vector2(- width, - height),
		Vector2(width, - height),
		Vector2(width, height),
	]
	right_boundary.position.x = width;
	left_boundary.position.x = -width;
	top_boundary.position.y = -height;
	bottom_boundary.position.y = height;
	draw_polyline(coords, color, thickness)
