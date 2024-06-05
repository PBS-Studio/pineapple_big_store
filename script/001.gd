extends Node2D


func _on_animation_player_animation_finished(_anim_name):
	Dialogic.start("linear_algebra")
	Dialogic.timeline_ended.connect(_dialogic_timeline_ended)


func _dialogic_timeline_ended():
	Dialogic.timeline_ended.disconnect(_dialogic_timeline_ended)
	RpgManager.change_scene("a_way_home")
