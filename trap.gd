extends Area2D

var canInteract = false

signal removeTrap

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

func destroyTrap():
    emit_signal("removeTrap")
    $CollisionShape2D.set_deferred("disabled",true)
    yield(get_tree().create_timer(0.5), "timeout")
    $CollisionShape2D.set_deferred("disabled",false)
    
    
func _on_trap_body_entered(body):
    if body.is_in_group('Player'):
        canInteract = true

# warning-ignore:unused_argument
func _physics_process(delta):
    interactWithTrap()
    
func interactWithTrap():
    if canInteract and Input.is_action_pressed("ui_select"):
        if GlobalWorld.tools["toolsBox"] :
            print('trap destroy')
            destroyTrap()
    
    
func _on_trap_body_exited(body):
    if body.is_in_group('Player'):
        canInteract = false

