extends Node2D

@export var piece_count = 5


var piece = preload("res://undertale_fight/scenes/attack/pineapple_piece.tscn")
@onready var animation_player = $AnimationPlayer
@onready var warning_area = %WarningArea


func init(property: Dictionary, _extra_info: Dictionary):
	position = property.get("position")
	piece_count = property.get("piece_count", piece_count)


func pineapple_fall():
	for node in warning_area.get_overlapping_bodies():
		if node is UndertalePlayer:
			node.take_damage(5)


func _ready():
	animation_player.play("fall")


func spawn_piece():
	for i in range(piece_count):
		var node = piece.instantiate()
		node.rotation = 2 * PI / piece_count * i
		node.speed = 800
		node.scale = Vector2.ONE * 1.6
		node.global_position = global_position
		add_sibling.call_deferred(node)


func _on_pineapple_animation_finished():
	queue_free()
