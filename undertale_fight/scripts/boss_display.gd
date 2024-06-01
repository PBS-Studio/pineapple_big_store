extends Node

@onready var damage_sound = $Damage
@onready var damage_display = $DamageDisplay
@onready var boss = %Boss
@onready var boss_health_bar = %BossHealthBar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func play_attacked_animation():
	%AttackAnimation.visible = true
	%AttackAnimation.play()

	var tween = create_tween()
	tween.tween_method(func(v: float): boss.position.x = 25 * (1 - v) * sin(6 * PI * v), 0.0, 1.0, 1.0).set_delay(0.5)
	tween.parallel().tween_callback(_damage_animation_callback).set_delay(0.4)


func _damage_animation_callback():
	damage_sound.play()
	damage_display.visible = true


func _on_attack_animation_animation_finished():
	%AttackAnimation.visible = false


func _on_boss_health_bar_health_change(old_health):
	damage_display.old_health = old_health
	damage_display.remain_health = boss_health_bar.remain_health
