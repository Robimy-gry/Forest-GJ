extends Area2D



func _on_Water_body_entered(body):
	if body.get_name() == "Player" and Input.is_action_pressed("use"):
		if GlobalWorld.tools["bucket"]== true:
			GlobalWorld.isBucketFilled = true
