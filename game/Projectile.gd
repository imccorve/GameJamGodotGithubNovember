extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var FIREBALL_SPEED = 200
func _ready():
	set_process(true)
	
func _process(delta):
	var speed_x = 1
	var speed_y = 0
	var motion = Vector2(speed_x, speed_y) * FIREBALL_SPEED
	set_pos(get_pos() + motion * delta)


func _on_VisibilityNotifier2D_exit_screen():
	queue_free()


func _on_Projectile_body_enter( body ):
	print("hmm")
	print(body)
	print("hmm")
	if body.is_in_group("player"):
		print("proje hit player")
		queue_free()
		body.take_damage(5)

