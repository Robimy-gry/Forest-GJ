extends Area2D
var canFillWater = false

func _physics_process(delta):
	refillWater()

func refillWater():
	if canFillWater == true and Input.is_action_pressed("ui_select"):
		if GlobalWorld.hasBucket == true:
			GlobalWorld.isBucketFilled = true

func _on_WaterArea_body_entered(body):
	if body.is_in_group('Player'):
		canFillWater = true
