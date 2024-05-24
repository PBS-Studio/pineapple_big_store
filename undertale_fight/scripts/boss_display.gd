extends Node

@onready var damage_sound = $Damage


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_attacked_animation():
	%AttackAnimation.visible = true
	%AttackAnimation.play()

	var tween = create_tween()
	tween.tween_method(func(v: float): %Boss.position.x = 25 * (1 - v) * sin(6 * PI * v), 0.0, 1.0, 1.0).set_delay(0.5)
	tween.parallel().tween_callback(func(): damage_sound.play()).set_delay(0.4)



func _on_attack_animation_animation_finished():
	%AttackAnimation.visible = false
