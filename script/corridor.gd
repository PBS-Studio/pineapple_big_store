extends Node2D

var limit = [0, 3, 2016, 291]


# Called when the node enters the scene tree for the first time.
func _ready():
	if Dialogic.VAR.fy_defeat:
		$Boss.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interact_area_interact():
	Dialogic.start("meetfy")
	Dialogic.timeline_ended.connect(_enter_undertale_fight)


func _enter_undertale_fight():
	Dialogic.timeline_ended.disconnect(_enter_undertale_fight)
	Dialogic.VAR.fy_defeat = true

	RpgManager.change_scene_no_effect("undertale_fight")


func _on_001_body_entered(_body):
	if not Dialogic.VAR.fy_defeat:
		return

	# TODO Add enter 001
