extends "res://scene/CustomRigidBody2D.gd"

#signal explode

export(int) var number_of_pieces = 3
export(int) var explode_force = 3
var explosion_speeds = [100, 200, 300,]



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

func _ready() -> void:	
	radius = sprite.texture.get_width() / 2 * sprite.scale
	collider = get_children()[1]
	explosionPlayer = get_children()[2]
	explosionPlayer.volume_db = GameHandler.game_settings.game.sfxVol
	explosionPlayer.connect("finished", self, "_on_explosionPlayer_finished")

func _explode():
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
		print(explosion_speed)
		for i in range(0,number_of_pieces):
			var offset_dir = PI * 2 / number_of_pieces * i
			var asteroid = lesser_asteroid.instance()
			asteroid.position = position + radius.rotated(offset_dir)
			asteroid.linear_velocity = linear_velocity + Vector2(explosion_speed,0).rotated(offset_dir)
			get_parent().add_child(asteroid)
	sleeping = true # prevents the object from interact while not free
	
func _on_explosionPlayer_finished():
	queue_free()
