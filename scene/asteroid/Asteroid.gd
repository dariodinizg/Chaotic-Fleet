extends "res://scene/CustomRigidBody2D.gd"

#signal explode

export(int) var number_of_pieces = 3
export(int) var explode_force = 2
var explosion_speeds = [100, 150]
export(float) var initial_velocity = 100.0
var initial_direction


enum Size {
	SMALL, MEDIUM, LARGE
}
export(Size) var size
var radius
var AsteroidTypes = {
	0: "res://scene/asteroid/small/AsteroidSmall.tscn",
	1: "res://scene/asteroid/medium/AsteroidMedium.tscn"
}
var collider
var explosionPlayer
var directions = [
	Vector2(-1.0,0.0), 
	Vector2(-1.0,1.0), 
	Vector2(0,1.0),
	Vector2(1.0,1.0), 
	Vector2(1,0), 
	Vector2(1,-1),
	Vector2(0,-1),
	Vector2(-1,-1)
	]

func _ready() -> void:	
	randomize()
	radius = sprite.texture.get_width() / 2 * sprite.scale
	collider = get_children()[1]
	explosionPlayer = get_children()[2]
	explosionPlayer.volume_db = GameHandler.game_settings.game.sfxVol
	explosionPlayer.connect("finished", self, "_on_explosionPlayer_finished")
	initial_direction = _get_initial_directions()
	apply_impulse(Vector2(),initial_direction *  initial_velocity)


func _get_initial_directions():
	return directions[randi() % directions.size()]

func _explode():
	if GameHandler.game_settings.game.is_sfx_on == true:
		explosionPlayer.play()
	sprite.queue_free()
	collider.queue_free()
	randomize()
	if self.size != Size.SMALL:
		var lesser_asteroid_value = self.size - 1
		var lesser_asteroid_type = AsteroidTypes[lesser_asteroid_value]
		var lesser_asteroid = load(lesser_asteroid_type)
	#		
		var explosion_speed = explosion_speeds[randi() % (explode_force-1)]
		for i in range(0,number_of_pieces):
			var offset_dir = PI * 2 / number_of_pieces * i
			var asteroid = lesser_asteroid.instance()
			asteroid.position = position + radius.rotated(offset_dir)
#			asteroid.linear_velocity = linear_velocity + Vector2(explosion_speed,0).rotated(offset_dir)
			get_parent().call_deferred("add_child", asteroid)
	sleeping = true # prevents the object from interact while not free
	
func _on_explosionPlayer_finished():
	queue_free()
