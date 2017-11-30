extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 0
var damage = 5
var direction = 0
var MAX_SPEED = 300
var MAX_HEALTH = 50
var health = 5
var path 
var attack = preload("res://attack.gd")
var DELAY_TIME = 1100
var attack_delay = DELAY_TIME
var is_attacking 


var projectile_scene = preload("res://game/Projectile.tscn")
func _ready():
	
	is_attacking = false
	path = get_parent()
	get_node("hitbox").connect("body_enter", self, "_on_hitbox_body_enter")
	set_process(true)
	
func _process(delta):
	path.set_offset(path.get_offset() + (50*delta))
	attack_delay -= 5
	if attack_delay <= 0 :
		print("enemy attacks")
		is_attacking = true
		var projectile = projectile_scene.instance()
		get_parent().get_parent().get_parent().add_child(projectile)
		projectile.set_pos(get_node("Position2D").get_global_pos())


		attack_delay = DELAY_TIME
		
func _on_hitbox_body_enter( body ):

	
	if (body extends attack):
		print("took damage")
		_take_damage()
	elif (body.is_in_group("player")):
		body.take_damage(damage)
		print("entered")
		pass
	
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
