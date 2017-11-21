extends ParallaxLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	
func _process(delta):
	var currPos = get_pos()
	currPos.x = currPos.x - 100 * delta
	set_pos(currPos)
