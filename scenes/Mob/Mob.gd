extends RigidBody2D


func _ready():
    # When Player enters, define instance constants
    # hide()

    # Set the animation to playing
    $AnimatedSprite.playing = true
    # For multiple sprite variations/animations
    var mob_types = $AnimatedSprite.frames.get_animation_names()
    $AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

func _process(delta):
    pass


# Remove instance from queue when mob instance exits screen
func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
