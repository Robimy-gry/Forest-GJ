extends Area2D

onready var tree = get_node("TreeSprite")
onready var fire = get_node("FireSprite")
onready var stump = get_node("Stump")
onready var burnt = get_node("BurntTree")
var trees = ["res://Sprites/trees/tree1.png", 
    "res://Sprites/trees/tree2.png", 
    "res://Sprites/trees/tree3.png"]
var tree_number


#signal usedWater

var canInteract = false
var deadTree = false
var isGrown = false
var isBurnt = false

# Called when the node enters the scene tree for the first time.
func _ready():
    tree_number = (randi() % trees.size())
    tree.texture = load(trees[tree_number])
    #fire.hide()
    stump.hide()
    tree.hide()
    burnt.hide()
    

func setFire():
    if !deadTree and !isBurnt and isGrown:
        $Fire.play()
        #tree.hide()
        #fire.show()
        $AnimatedSprite.show()
        $AnimatedSprite.play("fire")
        $BurnTimer.start()
    
        
func burnTree():
    if !deadTree and !isBurnt and isGrown:
        isBurnt = true
        GlobalWorld.burnt_trees += 1 # Burnt trees stats
        $Fire.stop()
        tree.hide()
        #fire.hide()
        $AnimatedSprite.stop()
        $AnimatedSprite.hide()
        burnt.show()
    
    
func putOutFire():
    if !deadTree:
        print("putout")
        tree.show()
        #fire.hide()
        $AnimatedSprite.stop()
        $AnimatedSprite.hide()
        $Fire.stop()
        $BurnTimer.stop()
        GlobalWorld.extinguished_trees += 1 #extinguished trees stats
        if GlobalWorld.isBucketFilled == true:
            $Splash.play()
        GlobalWorld.isBucketFilled = false
        #emit_signal("usedWater")
        get_tree().call_group("bucket", "usedWater")

func chopedTree():
    stump.show()
    tree.hide()
    #fire.hide()
    $AnimatedSprite.stop()
    $AnimatedSprite.hide()
    burnt.hide()
    if deadTree == false:
        $TreeCut.play()
    deadTree = true
    $Fire.stop()
    $BurnTimer.stop()
    GlobalWorld.chopped_trees += 1 # Chopped trees stats
    if deadTree == true:
        $DisappearTimer.start()

    
func _on_tree_body_entered(body):
    if body.is_in_group('Player'):
        canInteract = true

# warning-ignore:unused_argument
func _physics_process(delta):
    interactWithTree()
   
 
func interactWithTree():
    if canInteract and Input.is_action_just_pressed("ui_select") and isGrown:
        if GlobalWorld.tools["axe"] == true:
            chopedTree()
        if GlobalWorld.isBucketFilled == true and GlobalWorld.tools["bucket"] and ($AnimatedSprite.get_animation() == "fire") and !isBurnt:#and fire.is_visible_in_tree():
            putOutFire()
            get_tree().call_group("World", "guiBucketEmpty")
    
    
func _on_tree_body_exited(body):
    if body.is_in_group('Player'):
        canInteract = false


func grow():
    $AnimatedSprite.play("grow")


func _on_AnimatedSprite_animation_finished() -> void:
    if $AnimatedSprite.get_animation() == "grow":
        $AnimatedSprite.hide()
        isGrown = true
        GlobalWorld.grown_trees += 1
        tree.show()
    if $AnimatedSprite.get_animation() == "fire":
        $AnimatedSprite.flip_h = !$AnimatedSprite.flip_h

func _die():
    GlobalWorld.tree_count -= 1
    queue_free()


func _on_DisappearTimer_timeout() -> void:
    _die()
    

func _on_BurnTimer_timeout() -> void:
    burnTree()
