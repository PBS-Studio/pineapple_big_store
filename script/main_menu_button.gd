extends Button

signal click

@onready var custom_icon = $Icon
@onready var audio = $AudioStreamPlayer


func _ready():
	custom_icon.visible = false


func _on_mouse_entered():
	custom_icon.visible = true
	audio.play()


func _on_mouse_exited():
	custom_icon.visible = false


func _on_pressed():
	click.emit()
	audio.play()
