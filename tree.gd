extends Area2D

onready var tree = get_node("TreeSprite")
onready var fire = get_node("FireSprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	fire.hide()


func setFire():
	tree.hide()
	fire.show()
	
func putOutFire():
	tree.show()
	fire.hide()
	
	
func _on_tree_body_entered(body):
	if body.get_name() == 'Player' and GlobalWorld.isBucketFilled == true:
		putOutFire()
		GlobalWorld.isBucketFilled = false
