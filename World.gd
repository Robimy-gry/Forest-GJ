extends Node2D


#Stats

var burnt_trees = 0
var chopped_trees = 0
var grown_trees = 0
var destroyed_traps = 0
var extinguished_trees = 0
var time_played = 0

#End of Stats

var tree_count = 0

var tools = {
 "bucket":false,
 "axe":false,
"toolsBox":false
}

var isBucketFilled = false

signal toolwasChanged

# Called when the node enters the scene tree for the first time.
func _ready():
    add_to_group("World")
    guiInvisible()
    randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func changeTool(ele):
    if ele:
        for key in tools:
            tools[key] = false
        tools[ele] = true
        emit_signal("toolwasChanged")
        
func guiAxe():
    get_tree().call_group("GUI", "axeVisible")
    
func guiBucketEmpty():
    get_tree().call_group("GUI", "bucketEmptyVisible")

func guiBucketFull():
    get_tree().call_group("GUI", "bucketFullVisible")

func guiInvisible():
    get_tree().call_group("GUI", "invisible")

func _on_Trap_removeTrap():
    $traps/Trap.hide()
    yield(get_tree().create_timer(5.0),"timeout")
    $traps/Trap.show()
    pass # Replace with function body.

func resetStats():
    burnt_trees = 0
    chopped_trees = 0
    grown_trees = 0
    destroyed_traps = 0
    extinguished_trees = 0
    time_played = 0

func print_stats():
    print("\n\nStats\n")
    print("burnt_trees: ", burnt_trees)
    print("chopped_trees: ", chopped_trees)
    print("grown_trees: ", grown_trees)
    print("destroyed_traps: ", destroyed_traps)
    print("extinguished_trees: ", extinguished_trees)
    
