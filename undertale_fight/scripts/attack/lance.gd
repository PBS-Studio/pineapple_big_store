extends Node2D

@export var target: Vector2
@export var rotate_duration: float = 0.3
@export var rotate_delay: float = 0.2
@export var speed: float = 1000

@onready var audio = $AudioStreamPlayer

var v: Vector2


func init(property: Dictionary, extra_info: Dictionary):
	position = property.get("position")
	target = extra_info.get("player_position")


func _physics_process(delta):
	position += v * delta


func _ready():
	set_physics_process(false)
	v = (target - position).normalized() * speed
	var tween = create_tween()
	tween.tween_property(self, "rotation", position.angle_to_point(target), rotate_duration)
	tween.tween_callback(_shoot).set_delay(rotate_delay)


func _shoot():
	set_physics_process(true)
	audio.play()


func _on_area_2d_body_entered(body):
	if body is UndertalePlayer:
		body.take_damage(7)
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
