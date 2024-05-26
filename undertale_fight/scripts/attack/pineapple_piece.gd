extends Node2D

@export var speed: float
@export var rotate_speed: float = 5

@onready var piece = $Piece


func _process(delta):
	piece.rotate(rotate_speed * delta)
	position += speed * delta * Vector2.from_angle(rotation)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_body_entered(body):
	if body is UndertalePlayer:
		body.take_damage(1)
		queue_free()
