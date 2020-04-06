extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var canTakeAxe = false

# Called when the node enters the scene tree for the first time.
func _ready():
    $Stump.hide()
    $"/root/GlobalWorld".connect("toolwasChanged",self,"_on_World_toolChanged")
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
    
    getAxe()

func hideAxe():
    $Stump.show()
    $StumpAxe.hide()

func showAxe():
    $StumpAxe.show()
    $Stump.hide()
    

func getAxe():
    if canTakeAxe and Input.is_action_pressed("ui_select"):
        $CollisionShape2D.set_deferred("disabled",true)
        if GlobalWorld.tools["axe"] == false:
            GlobalWorld.changeTool("axe")
            hideAxe()
            get_tree().call_group("World", "guiAxe")
            print(GlobalWorld.isBucketFilled)
        else:
            GlobalWorld.tools["axe"] = false
            get_tree().call_group("World", "guiInvisible")
            showAxe()
        $PickObjectSFX.play()
        yield(get_tree().create_timer(0.5), "timeout")
        $CollisionShape2D.set_deferred("disabled",false)
    
func _on_axe_body_entered(body):
    if body.is_in_group('Player'):
        canTakeAxe = true


func _on_axe_body_exited(body):
    if body.is_in_group('Player'):
        canTakeAxe = false
        
        
    


func _on_World_toolChanged():
    print(GlobalWorld.tools)
    if GlobalWorld.tools["axe"] == false:
        showAxe() 

