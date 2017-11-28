extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const SAVE_PATH = "res://save.json"
var settings = {}

var screen_size = OS.get_screen_size()
var window_size = OS.get_window_size()

func _ready():
	#to center game window
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	set_process(true)
	#load_game()
	
func _process(delta):
	if Input.is_action_pressed("save"):
		save_game()
	if Input.is_action_pressed("load"):
		load_game()
		
func save_game():
	var save_dict = {}
	var save_nodes = get_tree().get_nodes_in_group("persistance")
	for node in save_nodes:



		var key = str(node.get_path())
		save_dict[key] = node.save()
		
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	
	save_file.store_line(save_dict.to_json())
	save_file.close()
	pass
	
func load_game():
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		return
	save_file.open(SAVE_PATH, File.READ)
	var data = {}
	data.parse_json(save_file.get_as_text())
	
	for node_path in data.keys():
		var node = get_node(node_path)
		
		for attribute in data[node_path]:
			if attribute == "pos":
				node.set_pos(Vector2(data[node_path]["pos"]["x"],data[node_path]["pos"]["y"]))
			else:
				node.set(attribute, data[node_path][attribute])
			
			
	