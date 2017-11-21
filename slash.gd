extends "attack.gd"

var old_layer_mask = 0
var old_collision_mask = 0

func _ready():
	set_process(false)
	disable()

func free():
	self.queue_free()

func enable():
    set_layer_mask(old_layer_mask)
    set_collision_mask(old_collision_mask)
func disable():
    old_layer_mask = get_layer_mask()
    old_collision_mask = get_collision_mask()
    set_layer_mask(0)
    set_collision_mask(0)

