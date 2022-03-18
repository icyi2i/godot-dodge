extends Area2D

# Signals
# An enemy collides with the player
signal hit


# Initialize
export var speed = 400
export var clamp_offset_x = 30
export var clamp_offset_y = 36
var screen_size


func _ready():
    # When Player enters, define instance constants
    screen_size = get_viewport_rect().size
    hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var velocity = Vector2.ZERO

    if Input.is_action_pressed("move_down"):
        velocity.y +=1
    if Input.is_action_pressed("move_up"):
        velocity.y -=1
    if Input.is_action_pressed("move_right"):
        velocity.x +=1
    if Input.is_action_pressed("move_left"):
        velocity.x -=1

    if velocity.x != 0:
        $AnimatedSprite.animation = "walk"
        $AnimatedSprite.flip_v = false
        $AnimatedSprite.flip_h = velocity.x < 0
    elif velocity.y != 0:
        $AnimatedSprite.animation = "move_up"
        $AnimatedSprite.flip_v = velocity.y > 0

    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        $AnimatedSprite.play()
    else:
        $AnimatedSprite.stop()

    position += velocity * delta
    position.x = clamp(position.x, clamp_offset_x, screen_size.x - clamp_offset_x)
    position.y = clamp(position.y, clamp_offset_y, screen_size.y - clamp_offset_y)


func _on_Player_body_entered(body):
    # Hide the player
    hide()
    emit_signal("hit")
    $CollisionShape2D.disabled = false
