extends Area2D

signal attack_finished
enum STATES {IDLE, ATTACK}
var current_state = IDLE

export(int) var damage = 1
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(false)

func attack():

	_change_state(ATTACK)
	
func _change_state(new_state):
	current_state = new_state
	if current_state == IDLE:
		set_process(false)
	else:
		set_process(true)
		
	
	
func _process(delta):

	#var overlapping_bodies = get_overlapping_areas()
	var overlapping_bodies = get_overlapping_areas()
	if overlapping_bodies == null:

		return
	print(overlapping_bodies)
	for body in overlapping_bodies:

		if body.is_in_group("enemy"):

			body.take_damage(damage)
	set_process(false)


func _on_AnimationPlayer_finished(name):
	if name == "attack":
		_change_state(IDLE) 

