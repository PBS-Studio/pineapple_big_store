extends Node2D


@export var old_health: int
@export var remain_health: int
@export var health_animation: float:
	set(value):
		health_animation = value
		if is_node_ready():
			health_bar.remain_health = lerp(old_health, remain_health, value)


@onready var health_bar = $HealthBar
@onready var number = $Number
@onready var animation = $AnimationPlayer


func _on_animation_player_animation_finished(anim_name):
	visible = false


func _on_visibility_changed():
	if not is_visible_in_tree():
		return
	
	number.text = " ".join(str(old_health - remain_health).split())
	animation.play("default")
