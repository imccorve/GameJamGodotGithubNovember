extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass





func _on_outerbounds_body_enter( body ):
	if body extends KinematicBody2D:
		print("out of bounds")
		body.set_pos(Vector2(0,0))

