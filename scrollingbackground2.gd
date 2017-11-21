extends ParallaxLayer

var offsetloc = 0 
func _ready(): 
	set_process(true) 
	
func _process(delta): 
	#offsetloc += -55 * delta 
	set_motion_offset(Vector2(offsetloc,0))