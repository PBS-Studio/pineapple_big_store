@tool
extends Node2D

@export var duration: float
@export var size: Vector2:
	set(value):
		size = value
		_update_boundary()
@export var color: Color
@export var thickness: float = 1


func update_boundary(new_size: Vector2, new_position: Vector2, callback: Callable):
	var tween = create_tween()
	tween.tween_property(self, "size", new_size, duration)
	tween.parallel().tween_property(self, "position", new_position, duration)
	tween.tween_callback(callback)


func _set(property: StringName, _value):
	if property == "position":
		_update_boundary()


func _update_boundary():
	if not is_node_ready():
		return
	_update_border()
	queue_redraw()


func _update_border():
	$FightBox.size = size - 2 * Vector2(thickness, thickness)
	$FightBox.position = -$FightBox.size / 2

	var width = size.x / 2 - thickness
	var height = size.y / 2 - thickness

	$"FightBorder/Right".position.x = position.x + width;
	$"FightBorder/Left".position.x = position.x - width;
	$"FightBorder/Top".position.y = position.y - height;
	$"FightBorder/Bottom".position.y = position.y + height;


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
