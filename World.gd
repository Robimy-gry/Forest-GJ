extends Node2D

var hasBucket = true # wartość 'true' jest do testów - w momencie, gdy będzie wiadro, 
					#to trzeba zmienić na 'false' i ustawiać true, gdy gracz podniesie wiadro
var isBucketFilled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
