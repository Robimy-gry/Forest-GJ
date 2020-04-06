extends MarginContainer

func _ready():
	add_to_group("GUI")

func _physics_process(delta):
	pass
	
func invisible():
	$NinePatchRect/Axe.visible = false
	$NinePatchRect/BucketFull.visible = false
	$NinePatchRect/BucketEmpty.visible = false
	$NinePatchRect/ToolBox.visible = false
	
func axeVisible():
	$NinePatchRect/Axe.visible = true
	$NinePatchRect/BucketFull.visible = false
	$NinePatchRect/BucketEmpty.visible = false
	$NinePatchRect/ToolBox.visible = false
	
func bucketEmptyVisible():
	$NinePatchRect/Axe.visible = false
	$NinePatchRect/BucketFull.visible = false
	$NinePatchRect/BucketEmpty.visible = true
	$NinePatchRect/ToolBox.visible = false
	
func bucketFullVisible():
	$NinePatchRect/Axe.visible = false
	$NinePatchRect/BucketFull.visible = true
	$NinePatchRect/BucketEmpty.visible = false
	$NinePatchRect/ToolBox.visible = false
	
func toolBoxVisible():
	$NinePatchRect/Axe.visible = false
	$NinePatchRect/BucketFull.visible = false
	$NinePatchRect/BucketEmpty.visible = false
	$NinePatchRect/ToolBox.visible = true
