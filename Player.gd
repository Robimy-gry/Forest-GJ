extends KinematicBody2D

const FRICTION = 300
const MAX_SPEED = 200
var velocity = Vector2.ZERO

func _ready():
    add_to_group("Player")

func _physics_process(delta):
    var input_vector = Vector2.ZERO
    input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    input_vector = input_vector.normalized()
    
    if input_vector != Vector2.ZERO:
        velocity = input_vector * MAX_SPEED
        if input_vector.y < 0:
            $AnimatedSprite.play("up")
        elif input_vector.x < 0:
            $AnimatedSprite.play("left")
        elif input_vector.x > 0:
            $AnimatedSprite.play("right")
        else:
            $AnimatedSprite.play("down")
    else:
        velocity = input_vector #changed to stop the player immediately
        $AnimatedSprite.play("stand")
        #velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
        
    if Input.is_action_just_pressed("ui_accept"):
        GlobalWorld.print_stats()
        
    
    move_and_collide(velocity * delta)
        
