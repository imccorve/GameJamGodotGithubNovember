extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass





func _on_outerbounds1_body_enter( body ):
	if body extends KinematicBody2D:
		body.set_pos(Vector2(0,0)) # replace with function body
