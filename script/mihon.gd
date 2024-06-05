extends CharacterBody2D


@export var speed = 150.0
@export var zoom_rate = 0.05
@export var motorcycle_speed = 200.0
@export var motorcycle_rotate = 0.06

@onready var animation = $AnimatedSprite2D
@onready var collision = $NormalCollision
@onready var camera = $Camera2D

var direction: Vector2 = Vector2.ZERO
var motorcycle_direction: float = 0

var mode: Mode = Mode.Normal
enum Mode{
	Normal,
	Motorcycle,
}

func _ready():
	set_process_input(false)
	set_process(false)
	position = Vector2.INF

func ride_motorcycle():
	mode = Mode.Motorcycle
	animation.visible = false
	collision.disabled = true
	velocity = Vector2.ZERO
	animation.stop()


func _exit_motorcycle():
	mode = Mode.Normal
	animation.visible = true
	collision.disabled = false
	animation.play("idle")
	$RideMotorcycle.exit_motorcycle()


func _physics_process(_delta):
	move_and_slide()
	if velocity != Vector2.ZERO:
		InteractManager.update_indicator(global_position)

	if mode == Mode.Motorcycle and Dialogic.current_timeline == null:
		_motorcycle_input()


func _input(_event):
	if Dialogic.current_timeline != null:
		return

	if mode == Mode.Normal:
		_normal_input()

	if Input.is_action_just_pressed("ui_cancel") and mode == Mode.Motorcycle:
		_exit_motorcycle()

	if Input.is_action_just_pressed("ui_interact"):
		InteractManager.interact()
	
	if Input.is_action_just_released("mouse_up"):
		camera.zoom += Vector2.ONE * zoom_rate

	if Input.is_action_just_released("mouse_down"):
		camera.zoom -= Vector2.ONE * zoom_rate

func _normal_input():
	var d = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if d != Vector2.ZERO and animation.animation == "idle":
		direction = d
		animation.play("walk")


func _motorcycle_input():
	if velocity != Vector2.ZERO:
		$RideMotorcycle.rotation_3d = velocity.angle()

	if not Input.is_action_pressed("ui_up"):
		velocity = Vector2.ZERO
		return

	if Input.is_action_pressed("ui_left"):
		motorcycle_direction -= motorcycle_rotate

	if Input.is_action_pressed("ui_right"):
		motorcycle_direction += motorcycle_rotate

	#$RideMotorcycle.rotation_3d = motorcycle_direction
	velocity = Vector2.from_angle(motorcycle_direction) * motorcycle_speed


func _on_animated_sprite_2d_frame_changed():
	if animation == null or animation.animation != "walk" or animation.frame != 3:
		return

	velocity = speed * direction


func _on_animated_sprite_2d_animation_finished():
	animation.play("idle")
	velocity = Vector2.ZERO
