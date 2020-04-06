extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var canOpened = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$OpenedBox.hide()
	$"/root/GlobalWorld".connect("toolwasChanged",self,"_on_World_toolChanged")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	takeTools()

func openBox():
	$OpenedBox.show()
	$CloseBox.hide()

func closeBox():
	$OpenedBox.hide()
	$CloseBox.show()
	

func takeTools():
	if canOpened and Input.is_action_pressed("ui_select"):
		if GlobalWorld.tools["toolsBox"] == false:
			GlobalWorld.changeTool("toolsBox")
			openBox()
			$PickObjectSFX.play()
			get_tree().call_group("GUI", "toolBoxVisible")
		else:
			GlobalWorld.tools["toolsBox"] = false
			closeBox()
			$PickObjectSFX.play()
			get_tree().call_group("GUI", "invisible")
		$CollisionShape2D.set_deferred("disabled",true)
		yield(get_tree().create_timer(0.5), "timeout")
		$CollisionShape2D.set_deferred("disabled",false)
	
	

func _on_box_body_entered(body):
	if body.is_in_group('Player'):
		canOpened = true


func _on_box_body_exited(body):
	if body.is_in_group('Player'):
		canOpened = false
		
		
	


func _on_World_toolChanged():
	print(GlobalWorld.tools)
	if GlobalWorld.tools["toolsBox"] == false:
		closeBox() 

