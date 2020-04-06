extends Node2D

var tilemap

export var spawn_area : Rect2 = Rect2(50, 50, 700, 700)
export var max_trees = 15
export var start_trees = 5
var tree_count = 0 setget , tree_count_get
var tree_scene = preload("res://tree.tscn")

var random = RandomNumberGenerator.new()

func tree_count_get():
	return tree_count

func instance_tree():
	
	#var tree = tree_scene.instance()
	#add_child(tree)
	var temp_x
	var temp_y
	var valid_position = false
	var counter = 0
	while not valid_position and counter < 50:
		counter +=1
		temp_x = spawn_area.position.x + random.randf_range(0, spawn_area.size.x)
		temp_y = spawn_area.position.y + random.randf_range(0, spawn_area.size.y)
		valid_position = test_position(Vector2(temp_x, temp_y+35))
		
	if (valid_position):
		var tree = tree_scene.instance()
		add_child(tree)
		tree_count += 1
		tree.position.x = temp_x
		tree.position.y = temp_y
		tree.grow()


func test_position(position : Vector2):
	
	var cell_coordinate = tilemap.world_to_map(position)
	var cell_type_id = tilemap.get_cellv(cell_coordinate)
	var is_grass = (cell_type_id == tilemap.tile_set.find_tile_by_name("Sprite11") ||
		cell_type_id == tilemap.tile_set.find_tile_by_name("Sprite7") ||
		cell_type_id == tilemap.tile_set.find_tile_by_name("Sprite3"))
	
	var collection_trees = get_children()

	var no_trees = true
	for tree_node in collection_trees:
		if tree_node.get_class() == "Area2D":
			if(
				(position.x < tree_node.get_position().x+120 && position.x > tree_node.get_position().x-120) &&
				(position.y < tree_node.get_position().y+120 && position.y > tree_node.get_position().y-120) 
				):
				no_trees = false
				break
	
	var players = get_tree().get_nodes_in_group("player")
	for player in players:
		if(
			(position.x < player.get_position().x+60 && position.x > player.get_position().x-60) &&
			(position.y < player.get_position().y+60 && position.y > player.get_position().y-60) 
			):
			no_trees = false
			break
			
	var objects = get_tree().get_nodes_in_group("objects")       
	for object in objects:
		if(
			(position.x < object.get_position().x+60 && position.x > object.get_position().x-60) &&
			(position.y < object.get_position().y+60 && position.y > object.get_position().y-60) 
			):
			no_trees = false
			break
	
	return is_grass and no_trees
	
	
		
func _ready():

	tilemap = get_tree().root.get_node("World/Grass")
	
	random.randomize()
	
	for i in range(start_trees):
		instance_tree()

func _on_Timer_timeout():
	
	if tree_count < max_trees:
		instance_tree()
