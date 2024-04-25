extends Node2D

const player_turn_box_size:Vector2 = Vector2(1030, 190)
const player_turn_box_position:Vector2 = Vector2(0, 110)

# Called when the node enters the scene tree for the first time.
func _ready():
	player_turn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func player_turn():
	$Player.visible = false
	%Boundary.resize(player_turn_box_size, player_turn_box_position, func(): $Buttons / Fight.grab_focus())


func _on_attack_bar_damage(percentage):
	if percentage == 0:
		boss_turn()
		return
	$AttackAnimation.visible = true
	%AttackAnimation.play()
	create_tween().tween_method(func(v: float): %Boss.position.x = 25 * (1 - v) * sin(6 * PI * v), 0.0, 1.0, 1.0).set_delay(0.5)


func _on_attack_animation_animation_finished():
	$AttackAnimation.visible = false
	boss_turn()


func boss_turn():
	$Player.visible = true
	player_turn()
