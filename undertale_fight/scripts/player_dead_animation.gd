extends Node2D

@export var player_position:Vector2

@onready var heart = $Heart
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	heart.global_position = player_position
	animation_player.play("break")

func _input(_event):
	if animation_player.is_playing():
		return
	
	get_tree().change_scene_to_file("res://undertale_fight/undertale_fight.tscn")
