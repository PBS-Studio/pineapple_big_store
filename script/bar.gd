extends Node2D

var limit = [2, - 42, 1154, 678]

@onready var spin = $Spin


# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.start("end")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_body_entered(body):
	print(body)
	var mihon = body as CharacterBody2D
	mihon.set_process_input(false)
	mihon.set_process(false)
	var camera = mihon.get_node("Camera2D")
	var tween = create_tween()
	tween.tween_property(camera, "global_position", spin.global_position, 2.0)
	tween.parallel().tween_property(camera, "zoom", 6 * Vector2.ONE, 6.0)

	# TODO
