extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var PROJECTILE_SPEED = 200
func _ready():
	set_process(true)
	
func _process(delta):
	var speed_x = 1
	var speed_y = 0
	var motion = Vector2(speed_x, speed_y) * PROJECTILE_SPEED
	set_pos(get_pos() + motion * delta)


func _on_VisibilityNotifier2D_exit_screen():
	queue_free()


func _on_Projectile_body_enter( body ):
	if body.is_in_group("player"):
		queue_free()
		body.take_damage(5)

