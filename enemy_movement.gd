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

	
	if (body extends attack):
		print("took damage")
		_take_damage()
	
func _take_damage():

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
