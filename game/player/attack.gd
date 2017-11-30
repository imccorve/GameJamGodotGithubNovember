extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
enum STATES {IDLE, ATTACK}
var current_state = IDLE
onready var area2d = get_node("Area2D")
func change_state(new_state):
	current_state = new_state
	if current_state == IDLE:
		area2d.set_enable_monitoring(false)
		set_process(false)
	else:
		area2d.set_enable_monitoring(true)
		set_process(true)
		
func _ready():
	area2d.set_enable_monitoring(false)
	set_process(false)
	
func _process(delta):
	pass
 





func _on_Area2D_body_enter( body ):
	if(body.is_in_group("enemy")):
		body._take_damage()

