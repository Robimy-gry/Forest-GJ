extends Area2D

onready var tree = get_node("TreeSprite")
onready var fire = get_node("FireSprite")
onready var stump = get_node("Stump")
var trees = ["res://Sprites/trees/tree1.png", 
    "res://Sprites/trees/tree2.png", 
    "res://Sprites/trees/tree3.png"]
var tree_number


signal usedWater

var canInteract = false
var deadTree = false

# Called when the node enters the scene tree for the first time.
func _ready():
    tree_number = (randi() % trees.size())
    tree.texture = load(trees[tree_number])
    fire.hide()
    stump.hide()
    tree.hide()

func setFire():
    if !deadTree:
        $Fire.play()
        tree.hide()
        fire.show()
    
func putOutFire():
    if !deadTree:
        tree.show()
        fire.hide()
        $Fire.stop()
        if GlobalWorld.isBucketFilled == true:
            $Splash.play()
        GlobalWorld.isBucketFilled = false
        #emit_signal("usedWater")
        get_tree().call_group("bucket", "usedWater")

func chopedTree():
    stump.show()
    tree.hide()
    fire.hide()
    if deadTree == false:
        $TreeCut.play()
    deadTree = true
    $Fire.stop()

    
func _on_tree_body_entered(body):
    if body.is_in_group('Player'):
        canInteract = true

# warning-ignore:unused_argument
func _physics_process(delta):
    interactWithTree()
    
func interactWithTree():
    if canInteract and Input.is_action_just_pressed("ui_select"):
        if GlobalWorld.tools["axe"] == true:
            chopedTree()
        if GlobalWorld.isBucketFilled == true and GlobalWorld.tools["bucket"] and fire.is_visible_in_tree():
            putOutFire()
    
func _on_tree_body_exited(body):
    if body.is_in_group('Player'):
        canInteract = false

func grow():
    $AnimatedSprite.play("grow")

func _on_AnimatedSprite_animation_finished() -> void:
    tree.show()
