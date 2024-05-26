extends Node2D

signal player_turn
signal boss_turn

@export var fight_list: Array[StringName]

const player_turn_box_size: Vector2 = Vector2(775, 190)
const player_turn_box_position: Vector2 = Vector2(0, 110)
@onready var player_health = %PlayerHealthBar
@onready var player = %Player
@onready var boss_health = %BossHealthBar
@onready var boss_display = %BossDisplay
@onready var boundary = %Boundary
@onready var fight_player = %FightPlayer

var death_screen=preload("res://undertale_fight/scenes/death_screen.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	#_on_attack_bar_attack_bar_hiding()
	_player_turn_menu()
	pass


func _on_attack_bar_damage(percentage):
	if percentage == 0:
		return

	var damage
	if percentage >= 0.95:
		damage = floori(player_health.remain_health as float * randf_range(1.0, 1.5))
	damage = floori(player_health.remain_health as float * percentage)
	damage += randi_range(0, 5)

	boss_health.take_damage(damage)
	boss_display.play_attacked_animation()


func _on_attack_bar_attack_bar_hiding():
	boss_turn.emit()
	fight_player.play(fight_list[randi_range(1, fight_list.size()) - 1])
	#fight_player.play("pineapple_rain")


func _player_turn_menu():
	%Player.visible = false
	boundary.update_boundary(player_turn_box_size, player_turn_box_position, _player_turn_menu_callback)


func _player_turn_menu_callback():
	player_turn.emit()


func _on_fight_player_animation_finished(_anim_nam0e):
	_player_turn_menu()


func _on_player_health_bar_health_zeroed():
	var scene = death_screen.instantiate()
	scene.player_position = player.global_position
	get_tree().root.add_child(scene)
	get_tree().current_scene = scene
	queue_free()
