extends Node

export(PackedScene) var mob_scene
var score


func _ready():
    randomize()


func game_over():
    $ScoreTimer.stop()
    $MobTimer.stop()

func new_game():
    score = 0
    $Player.start($StartPosition.position)
    $StartTimer.start()

func _on_ScoreTimer_timeout():
    score += 1

func _on_StartTimer_timeout():
    $MobTimer.start()
    $ScoreTimer.start()

func _on_MobTimer_timeout():
    var mob = mob_scene.instance()

    var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
    mob_spawn_location.offset = randi()
    mob.position = mob_spawn_location.position

    var mob_direction = mob_spawn_location.rotation + PI / 2
    mob_direction += rand_range(-PI / 4, PI / 4)
    mob.rotation = mob_direction

    var mob_velocity = Vector2(rand_range(150,250), 0)
    mob.linear_velocity = mob_velocity.rotated(mob_direction)

    add_child(mob)