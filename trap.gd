extends Area2D

var canInteract = false

# Called when the node enters the scene tree for the first time.
func _ready():
    $close.hide()
    pass

func destroyTrap():
    $close.show()
    $trap.hide()
    $CollisionShape2D.set_deferred("disabled",true)
    yield(get_tree().create_timer(1), "timeout")
    $CollisionShape2D.set_deferred("disabled",false)
    GlobalWorld.trap_count -= 1
    GlobalWorld.destroyed_traps += 1
    queue_free()
    
    
func _on_trap_body_entered(body):
    if body.is_in_group('Player'):
        canInteract = true

# warning-ignore:unused_argument
func _physics_process(delta):
    interactWithTrap()
    
func interactWithTrap():
    if canInteract and Input.is_action_pressed("ui_select"):
        if GlobalWorld.tools["toolsBox"] :
            destroyTrap()
    
    
func _on_trap_body_exited(body):
    if body.is_in_group('Player'):
        canInteract = false

