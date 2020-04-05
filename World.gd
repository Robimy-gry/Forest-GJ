extends Node2D

var collection_trees = null
var tools = {
 "bucket":false,
 "axe":false
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

