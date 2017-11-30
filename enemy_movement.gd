extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 0
var damage = 5
var direction = 0
var MAX_SPEED = 300
var MAX_HEALTH = 50
var health = 1
var path 
var attack = preload("res://attack.gd")
var DELAY_TIME = 400
var attack_delay = DELAY_TIME
var is_attacking 
func _ready():
	
	is_attacking = false
	path = get_parent()
	get_node("hitbox").connect("body_enter", self, "_on_hitbox_body_enter")
	set_process(true)
	
func _process(delta):
	path.set_offset(path.get_offset() + (50*delta))

		
func _on_hitbox_body_enter( body ):
	print("entering enemy " + body.get_name())
	#if (body.is_in_group("attack")):
	#	print("Helloooo")
	#	_take_damage()
	#print(body.get_name())
	#if (body extends attack):
	#	print("enemy attacked")
	#	_take_damage()
	#elif (body.is_in_group("player")):
	#	body.take_damage(damage)
	if(body.is_in_group("player")):
		body.take_damage(damage)
		
	
func _take_damage():

	health -= damage
	if health <= 0:
		print("dead")
		_death()
		
func _death():
	queue_free()



func _on_hitbox_area_enter( area ):

	if (area.is_in_group("attack")):
		_take_damage()
	if (area extends attack):
		print("enemy attacked")
		_take_damage()



