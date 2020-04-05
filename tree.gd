extends Area2D

onready var tree = get_node("TreeSprite")
onready var fire = get_node("FireSprite")
onready var stump = get_node("Stump")


signal usedWater

var canInteract = false
var deadTree = false

# Called when the node enters the scene tree for the first time.
func _ready():
	fire.hide()
	stump.hide()

func setFire():
	if !deadTree:
		tree.hide()
		fire.show()
	
func putOutFire():
	if !deadTree:
		tree.show()
		fire.hide()
		GlobalWorld.isBucketFilled = false
		emit_signal("usedWater")

func chopedTree():
	stump.show()
	tree.hide()
	fire.hide()
	deadTree = true
	
func _on_tree_body_entered(body):
	if body.is_in_group('Player'):
		canInteract = true

# warning-ignore:unused_argument
func _physics_process(delta):
	interactWithTree()
	
func interactWithTree():
	if canInteract and Input.is_action_pressed("ui_select"):
		if GlobalWorld.tools["axe"] == true:
			chopedTree()
		if GlobalWorld.isBucketFilled == true and GlobalWorld.tools["bucket"] and fire.is_visible_in_tree():
			putOutFire()

func _on_tree_body_exited(body):
	if body.is_in_group('Player'):
		canInteract = false
