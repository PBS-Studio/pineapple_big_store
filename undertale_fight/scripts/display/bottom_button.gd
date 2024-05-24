extends Button

signal enter_menu(btn: Button)

@onready var audio_player = $AudioStreamPlayer


func _on_focus_entered(): 
	$Heart.visible = true
	audio_player.play()


func _on_focus_exited(): 
	$Heart.visible = false


func _on_pressed(): 
	release_focus()
	audio_player.play()
	enter_menu.emit(self)
