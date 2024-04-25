@tool
extends Node2D

@export var duration: float
@export var size: Vector2
	# for tool only
	#set(value):
		#size = value
		#if is_node_ready() :
			#create_tween().tween_property(self,"current_size", size, duration)
@export var color: Color
@export var thickness: float = 1


func resize(new_size: Vector2, new_position: Vector2, callback: Callable):
	var tween = create_tween()
	tween.tween_property(self, "size", new_size, duration)
	tween.parallel().tween_property(self, "position", new_position, duration)
	tween.tween_callback(callback)


func _set(property, value):
	if property == "size" or property == "position":
		_update_boundary()
		queue_redraw()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _update_boundary():
	$FightBox.size = size - 2 * Vector2(thickness, thickness)
	$FightBox.position = -$FightBox.size / 2

	var width = size.x / 2 - thickness
	var height = size.y / 2 - thickness

	$"WorldBorder/Right".position.x = position.x + width;
	$"WorldBorder/Left".position.x = position.x - width;
	$"WorldBorder/Top".position.y = position.y - height;
	$"WorldBorder/Bottom".position.y = position.y + height;


func _draw():
	var width = size.x / 2 - thickness / 2
	var height = size.y / 2 - thickness / 2

	var coords: PackedVector2Array = [
		Vector2(width, height),
		Vector2(- width, height),
		Vector2(- width, - height),
		Vector2(width, - height),
		Vector2(width, height),
	]
	draw_polyline(coords, color, thickness)
