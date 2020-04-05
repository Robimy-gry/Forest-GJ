extends Area2D
var canFillWater = false

signal filledBucket

func _physics_process(delta):
	refillWater()

func refillWater():
	if canFillWater == true and Input.is_action_pressed("ui_select"):
		if GlobalWorld.tools["bucket"] == true:
			GlobalWorld.isBucketFilled = true
			emit_signal("filledBucket")

func _on_WaterArea_body_entered(body):
	if body.is_in_group('Player'):
		canFillWater = true


func _on_WaterArea_body_exited(body):
	if body.is_in_group('Player'):
		canFillWater = false
