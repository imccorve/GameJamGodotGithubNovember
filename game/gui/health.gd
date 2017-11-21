extends TextureProgress
var player
func _ready():
	player = get_tree().get_root().get_node("Node").get_node("Player")
	set_process(true)
	
func _process(delta):
	
	set_value(player.health)
	pass
	
