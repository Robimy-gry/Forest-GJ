extends Node2D

var collection_trees = null
var tools = {
 "bucket":false,
 "axe":false,
"toolsBox":false
}

var isBucketFilled = false

signal toolwasChanged

# Called when the node enters the scene tree for the first time.
func _ready():
    
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



func _on_Trap_removeTrap():
    $traps/Trap.hide()
    yield(get_tree().create_timer(5.0),"timeout")
    $traps/Trap.show()
    pass # Replace with function body.
