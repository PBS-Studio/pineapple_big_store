extends Control

@export var text: String

var id
signal selected(id)

@onready var audio_player = $AudioStreamPlayer


func _ready(): 
	$Text.text = "*  %s" % text


func _set(property, value): 
	if property == "text": 
		$Text.text = "*  %s" % value


func _on_focus_entered(): 
	$Button.grab_focus()


func _on_button_pressed(): 
	$Button.release_focus()
	audio_player.play()
	selected.emit(id)
