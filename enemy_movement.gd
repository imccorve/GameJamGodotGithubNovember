extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 0
var damage = 1
var direction = 0
var MAX_SPEED = 300
var MAX_HEALTH = 50
var health = 1
var path 
var attack = preload("res://attack.gd")

func _ready():
	path = get_parent()
	get_node("hitbox").connect("body_enter", self, "_on_hitbox_body_enter")
	set_process(true)
	
func _process(delta):
	path.set_offset(path.get_offset() + (50*delta))
	if is_colliding():
		print("colliding")
		var entity = get_collider()
		if entity.is_in_group("player"):
			print("hit player")
		
func _on_hitbox_body_enter( body ):
	print(str('Body entered: ', body.get_name()))
	
	if (body extends attack):
		print("took damage")
		_take_damage()
	
func _take_damage():
	print("take damage")
	health -= damage
	if health <= 0:
		print("dead")
		_death()
		
func _death():
	#hacky death
	print("death")
	get_node("CollisionShape2D").set_trigger(true)
	hide()
	set_process(false)
	pass