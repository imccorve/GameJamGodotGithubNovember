extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (NodePath) var button_path
onready var button = get_node(button_path)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	button.connect("pressed", self, "on_pressed")
	
	
func on_pressed():
	get_tree().change_scene("res://game/scenes/level1/World.tscn")
	
