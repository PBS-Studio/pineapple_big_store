extends CharacterBody2D
class_name UndertalePlayer

signal player_damage(damage: int)

@export var speed: float
@export var player_health_bar: Node2D

@onready var animation_player = $AnimationPlayer
@onready var hurt_sound = $Hurt


func take_damage(damage: int):
	if animation_player.is_playing():
		return
	
	player_health_bar.take_damage(damage)
	hurt_sound.play()
	animation_player.play("damage")
	animation_player.queue("damage")
	if damage <= 2:
		return
	
	animation_player.queue("damage")
	if damage <= 5:
		return
	
	animation_player.queue("damage")
	if damage <= 10:
		return
	
	animation_player.queue("damage")


func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed * delta
	move_and_slide()


func _on_visibility_changed():
	var is_active = is_visible_in_tree()
	set_process(is_active)
	set_process_input(is_active)
