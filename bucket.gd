extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var canTakeBucket = false
var isBucketFilled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$FilledBucket.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func showFilled():
	$FilledBucket.show()
	$EmptyBucket.hide()

func showEmpty():
	$FilledBucket.hide()
	$EmptyBucket.show()


func _physics_process(delta):
	getBucket()


func getBucket():
	if canTakeBucket and Input.is_action_pressed("ui_select"):
		$CollisionShape2D.set_deferred("disabled",true)
		if GlobalWorld.tools['bucket'] == false:
			GlobalWorld.changeTool('bucket')
		else:
			GlobalWorld.tools['bucket'] = false
		yield(get_tree().create_timer(0.5), "timeout")
		$CollisionShape2D.set_deferred('disabled',false)


func _on_bucket_body_entered(body):
	if body.is_in_group('Player'):
		canTakeBucket = true


func _on_bucket_body_exited(body):
	if body.is_in_group('Player'):
		canTakeBucket = false


func _on_WaterArea_filledBucket():
	showFilled()


func _on_tree_5_usedWater():
	showEmpty()


func _on_tree_4_usedWater():
	showEmpty()


func _on_tree_2_usedWater():
	showEmpty()


func _on_tree_1_usedWater():
	showEmpty()


func _on_tree_3_usedWater():
	showEmpty()


func _on_World_toolChanged():
	print('changed')
	pass # Replace with function body.
