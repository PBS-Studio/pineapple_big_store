extends Node2D

var limit = [ - 48, 0, 1584, 3360]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_corridor_body_entered(_body):
	RpgManager.change_scene_and_tp("corridor", "ExitBigRoad")
	
func _enter_godown():
	Dialogic.timeline_ended.disconnect(_enter_godown)
	Dialogic.VAR.godown_complete = true

	RpgManager.change_scene_no_effect("just_go_down")
	


func _on_pineapplerain_body_entered(body):
	if not Dialogic.VAR.isekai_complete:
		return
	if not Dialogic.VAR.rain:
		Dialogic.VAR.rain = true
		Dialogic.start("pineapple_rain")
		Dialogic.timeline_ended.connect(_enter_godown)


func _on_college_road_body_entered(body):
	RpgManager.change_scene_and_tp("college_road", "ExitBigRoad")


func  _enter_crash():
	Dialogic.timeline_ended.disconnect(_enter_crash)
	RpgManager.change_scene_and_tp("bar","come")

func _on_crash_body_entered(body):
	if not Dialogic.VAR.godown_complete:
		return
	
	$AnimationPlayer.play("crash")
	Dialogic.start("crash")
	Dialogic.timeline_ended.connect(_enter_crash)
	Dialogic.signal_event.connect(_black_screen)
	
func _black_screen(ev):
	if ev != "crash":
		return
	
	$Crash.visible = true
