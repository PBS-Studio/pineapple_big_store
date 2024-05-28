extends Node2D

@export var duration: float
@export var target: Vector2 = Vector2.ZERO


func _ready():
	rotation = position.angle_to_point(target)
	create_tween().tween_property(self, "position", target, duration).set_ease(Tween.EASE_IN)


func _on_area_2d_body_entered(body):
	if body is UndertalePlayer:
		body.take_damage(2)
		queue_free()
