extends CharacterBody2D


@export var speed: float
@export var mode: Mode

enum Mode {
	Battle,
	Select
}

func _physics_process(delta):
	if mode == Mode.Battle:
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = direction * speed * delta
		move_and_slide()
		return
	
