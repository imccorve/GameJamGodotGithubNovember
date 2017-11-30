extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var player = get_node("Player")
	var interactables = get_tree().get_nodes_in_group("Interactable")
	for i in range(interactables.size()):

		var currNode = get_node(interactables[i].get_path())
		var area2DNode = currNode.get_node("Area2D")
		var args = Array([currNode])
		area2DNode.connect("body_enter", player, "_on_Area2D_body_enter", args)
		area2DNode.connect("body_exit", player, "_on_Area2D_body_exit", args)
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_attackbox_body_enter( body ):
	pass # replace with function body
