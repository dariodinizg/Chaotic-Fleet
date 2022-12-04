extends "res://scene/CustomRigidBody2D.gd"

class_name PLAYER

signal player_exploded

export(float) var engine_thrust = 100
export(float) var spin_thrust = 3
export(int) var bullet_ammo

var pre_bullet = preload("res://scene/bullet/bullet.tscn")
var velocity = Vector2()
var rotation_direction = 0

func _ready():
	$CannonSound.volume_db = GameHandler.game_settings.game.sfxVol - 3.0

func check_input_movement(delta):
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(engine_thrust,0)
	else:
		velocity = Vector2()
	
	if Input.is_action_pressed("ui_left"):
		rotation_direction -= 1 * delta
	if Input.is_action_pressed("ui_right"):
		rotation_direction += 1 * delta
	
func check_input_shoot():
	if Input.is_action_just_pressed("ui_shoot"):
		var bullet = pre_bullet.instance()
		bullet.position = $CannonPosition.global_position
		bullet.rotation = self.rotation
		$CannonSound.play()
		get_parent().add_child(bullet)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_input_movement(delta)
	check_input_shoot()
		
func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	rotation += rotation_direction * spin_thrust
	set_applied_force(velocity.rotated(rotation))
	._integrate_forces(state) # parent's method

func check_collision(body):
	if body.is_in_group("asteroid"):
#		print("collided")
		queue_free()
		emit_signal("player_exploded")


func _on_Area2D_body_entered(body):
	check_collision(body)
