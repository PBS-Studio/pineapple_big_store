extends Node2D

@onready var end_game=$end_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("p"):
		end_game.play()
		await end_game.finished
		RpgManager.change_scene_and_tp("corridor","Exit001")
