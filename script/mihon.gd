extends CharacterBody2D

@onready var animation = $AnimatedSprite2D


@export var speed = 150.0
var direction: Vector2=Vector2.ZERO


func _physics_process(_delta):
	move_and_slide()
	if velocity != Vector2.ZERO:
		InteractManager.update_indicator(global_position)


func _input(_event):
	if Dialogic.current_timeline != null:
		return
	
	var d = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if d != Vector2.ZERO and animation.animation == "idle":
		direction = d
		animation.play("walk")

	if Input.is_action_just_pressed("ui_accept"):
		InteractManager.interact()


func _on_animated_sprite_2d_frame_changed():
	if animation == null or animation.animation != "walk" or animation.frame != 3:
		return

	velocity = speed * direction


func _on_animated_sprite_2d_animation_finished():
	animation.play("idle")
	velocity = Vector2.ZERO
