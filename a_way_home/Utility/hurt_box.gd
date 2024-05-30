extends Area2D

@export_enum("Cooldown","HitOnce","DisableHitBox") var HurtBoxType=0

@onready var collision=$CollisionShape2D
@onready var disableTimer=$DisableTimer

signal hurt(damage) #自定一個名為 hurt 的信號，帶有一個參數 damage

func _on_area_entered(area):
	if area.is_in_group("attack"): #屬於attack group的東西進入area
		if not area.get("damage")==null: #檢查進入的區域是否有 damage 屬性，且其值不為 null
			match  HurtBoxType:
				0 : #Cooldown
					collision.call_deferred("set","disabled",true) #讓collision shape 消失
					disableTimer.start() #開始計時
				1 : #HitOnce
					pass
				2 : #DisableHitBox
					if area.has_method("tempdisable"): #如果 area 有 tempdisable 方法，則調用該方法
						area.tempdisable()
			var damage=area.damage #獲取 damage 值
			emit_signal("hurt",damage) #當受到攻擊時，程式碼會發出 hurt 信號，通知hit_box受到的傷害值 damage, 
			if area.has_method("enemy_hit"): #當hurt box 偵測到帶有enemy_hit 的func時
				area.enemy_hit(1) #回傳訊號1

func _on_disable_timer_timeout():
	collision.call_deferred("set","disabled",false) #重啟 collision shape
