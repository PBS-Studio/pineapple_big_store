extends Area2D

var level=1
var hp=9999
var speed = 250
var damage=5
var knockback_amount=100
var paths=1 #曲折次數
var attack_size=1.5 #武器大小(範圍)
var attack_speed=4.0 #攻擊間隔

var target=Vector2.ZERO
var target_array=[]

var angle=Vector2.ZERO
var reset_pos=Vector2.ZERO

# sprite javelin regular
var spr_jav_reg=preload("res://a_way_home/survivor template/Textures/Items/Weapons/javelin_3_new.png")
# sprite javelin attack
var spr_jav_atk=preload("res://a_way_home/survivor template/Textures/Items/Weapons/javelin.png")

@onready var player=get_tree().get_first_node_in_group("human_player")
@onready var sprite= $Sprite2D
@onready var collision=$CollisionShape2D
@onready var attackTimer=get_node("%AttackTimer")
@onready var changeDirectionTimer=get_node("%ChangeDirection")
@onready var resetPosTimer=get_node("%ResetPosTimer")
@onready var snd_attack=$snd_attack

signal remove_from_array(object)

func _ready():
	collision.call_deferred("set","disabled",true) #一開始未攻擊先將collision 關閉
	update_javelin()
	
func update_javelin():
	level = player.javelin_level #在human player 中設定 javelin level
	match level:
		1:
			var hp=9999
			var speed = 250
			var damage=5
			var knockback_amount=100
			var paths=1 #曲折次數
			var attack_size=1.5 #武器大小(範圍)
			var attack_speed=4.0 #攻擊間隔	
	scale=Vector2(1.0,1.0)*attack_size
	attackTimer.wait_time=attack_speed
	
func _physics_process(delta):
	if target_array.size()>0:
		position+=angle*speed*delta
		
func add_path():
	snd_attack.play()
	emit_signal("remove_from_array",self) #不要加進hurt_box
	target_array.clear() #先清空目標敵人
	var counter=0
	while counter<paths:
		var new_path=player.get_random_target()
		target_array.append(new_path)
		counter+=1
		enable_attack(true)
	target=target_array[0]
	process_path()

func process_path():
	angle=global_position.direction_to(target)
	changeDirectionTimer.start()

func enable_attack(atk=true):
	if atk==true:
		collision.call_deferred("set","disabled",false)
		sprite.texture=spr_jav_atk
	else:
		collision.call_deferred("set","disabled",true)
		sprite.texture=spr_jav_reg

func _on_attack_timer_timeout():
	add_path()

func _on_change_direction_timeout(): #時間到開始尋找新敵人
	if target_array.size()>0:
		target_array.remove_at(0) # 刪掉第一個敵人，選下一個
		
		if target_array.size()>0: #若有下一個敵人可選
			target=target_array[0]
			process_path()
			snd_attack.play()
		else: #no more enemy
			enable_attack(false)
			
	else: #no more enemy
		changeDirectionTimer.stop()
		attackTimer.start()
		enable_attack(false)
			
			
			
	
