extends Node





# Called when the node enters the scene tree for the first time.
func _ready():
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func getTree(index):
    #var path = "tree_"+String(index)
    var node = find_node("TreeSpawner").get_child(index)
    return node


func _on_TreeTimer_timeout():
    #node 0 is Timer, so counting from node 1
    var index = (randi() % find_node("TreeSpawner").get_child_count()-1)+1
    if(getTree(index).name != "Timer"):
        getTree(index).setFire()
    
