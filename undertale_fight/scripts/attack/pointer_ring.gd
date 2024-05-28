extends Node2D

@export var pointer_count: int = 11
@export var radius: int = 300
@export var duration: float = 3
var pointer = preload("res://undertale_fight/scenes/attack/pointer.tscn")


func init(property: Dictionary, extra_info: Dictionary):
	position = extra_info.get("player_position")
	pointer_count = property.get("pointer_count", pointer_count)
	radius = property.get("radius", radius)
	

func _ready():
	for i in range(pointer_count):
		var node = pointer.instantiate()
		node.duration = duration
		node.position = radius * Vector2.from_angle(2 * PI / pointer_count * i )
		add_child(node)

	var tween = create_tween()
	tween.tween_method(_rotate, 0.0, PI, duration).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.1)
	tween.tween_callback(func(): queue_free())

func _rotate(i:float):
	rotation = PI * sin(i)
	
