extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var message = get_node("Message")
onready var tooltip = get_node("Tooltip")
var canInteract = false
var string_format = "STATS\n\nGrown trees: %s\nChopped trees: %s\nRemoved traps: %s\nExtinguished trees: %s\nBurnt trees: %s"

var text = string_format #"Domek Miszcza Lasu"
# Called when the node enters the scene tree for the first time.
func _ready():
    message.hide()
    tooltip.hide()
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func showMessage():
    if canInteract and Input.is_action_pressed("ui_select"):
        $Message/text.text = string_format % [GlobalWorld.grown_trees, GlobalWorld.chopped_trees, GlobalWorld.destroyed_traps, GlobalWorld.extinguished_trees, GlobalWorld.burnt_trees]
        message.show()
        tooltip.hide()

func _on_Area2D_body_entered(body):
    if body.is_in_group('Player'):
        canInteract = true
        tooltip.show()

func _physics_process(delta):
        showMessage()


func _on_Area2D_body_exited(body):
    if body.is_in_group('Player'):
        canInteract = false
        tooltip.hide()
        message.hide()
