extends Node2D

var limit = [0, 3, 2016, 291]

# Called when the node enters the scene tree for the first time.
func _ready():
	if Dialogic.VAR.fy_defeat:
		$Boss.queue_free()
		if not Dialogic.VAR.talk:
			Dialogic.VAR.talk = true
			Dialogic.start("afterbattle")
	
	if Dialogic.VAR.isekai_complete and not Dialogic.VAR.isekai_talk:
		Dialogic.VAR.isekai_talk = true
		Dialogic.start("isekaiafter")
	

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
	if not Dialogic.VAR.fy_defeat or Dialogic.VAR.isekai_complete:
		return
	Dialogic.VAR.isekai_complete = true
	RpgManager.change_scene_no_effect("001")


func _on_big_road_body_entered(body):
	RpgManager.change_scene_and_tp("big_road", "ExitCorridor")
