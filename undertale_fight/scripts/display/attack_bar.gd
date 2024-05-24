extends Node2D

signal damage(percentage: float)

signal attack_bar_hiding

const attack_duration: float = 1.2
const missing_padding: float = 0.15

var tween: Tween
var half_width: int
var reset_scale_x: float

@onready var attack_sound=$AudioStreamPlayer

func _ready():
	set_process_input(false)	
	half_width = -$Bar.position.x
	reset_scale_x = scale.x
	visible = false


# Need call this to reset attack bar
func init_attack_bar():
	# reset all property
	if tween != null:
		tween.kill()

	$Bar.position.x = -half_width
	$Bar.visible = true
	$Bar.modulate = Color.WHITE
	$Bar.scale = Vector2.ONE
	scale.x = reset_scale_x
	modulate = Color.WHITE
	visible = true

	tween = create_tween()
	tween.tween_callback(func(): set_process_input(true)).set_delay(0.5)
	tween.tween_property($Bar, "position:x", half_width, attack_duration)
	tween.tween_callback(_not_attack)


func _attack():
	set_process_input(false)	
	tween.kill()
	tween = create_tween()
	tween.tween_method(func(p: int): $Bar.material.set_shader_parameter("active", p & 1 != 0), 0, 20, 2)
	tween.tween_callback(func(): $Bar.visible = false)
	tween.tween_callback(_hide_attack_bar).set_delay(0.2)
	damage.emit( 1.0 - min (abs($Bar.position.x) / half_width, 1.0) )


func _not_attack():
	set_process_input(false)
	tween = create_tween()
	tween.tween_property($Bar, "position:x", missing_padding * half_width, missing_padding * attack_duration).as_relative()
	tween.parallel().tween_property($Bar, "modulate", Color.TRANSPARENT, missing_padding * attack_duration).set_delay(0.2)
	tween.parallel().tween_property($Bar, "scale", 1.5 * Vector2.ONE, missing_padding * attack_duration).set_delay(0.2)
	tween.tween_callback(_hide_attack_bar).set_delay(0.2)
	damage.emit(0)


func _hide_attack_bar():
	tween = create_tween()
	attack_bar_hiding.emit()
	tween.parallel().tween_property(self, "scale:x", 0, 0.7)
	tween.parallel().tween_property(self, "modulate", Color.BLACK, 0.5)
	tween.tween_callback(func(): visible = false)

func _input(_event):
	if Input.is_action_just_pressed("ui_accept"):
		_attack()
		attack_sound.play()
