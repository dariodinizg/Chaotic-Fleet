class_name PLAYER

extends "res://scene/CustomRigidBody2D.gd"

signal player_exploded

export(float) var engine_thrust = 100
export(float) var spin_thrust = 3
export(int) var bullet_ammo

var pre_bullet = preload("res://scene/bullet/bullet.tscn")
var velocity = Vector2()
var rotation_direction = 0

enum { MOVING, DEAD }
var current_state = MOVING
var is_state_starting = true

func behave(_delta):
	match current_state:
		MOVING:
			_moving_state(_delta)
			_check_moving_state()
		DEAD:
			_dead_state()
			_check_dead_state()

	
func _moving_state(_delta):
	_check_input_movement(_delta)
	_check_input_shoot()
	
func _dead_state():
	queue_free()
	emit_signal("player_exploded")

func _check_moving_state():
	pass
	

func _check_dead_state():
	pass

# SET STATE FUNC
func _set_state(state):
	if current_state != state:
		is_state_starting = true
	else:
		is_state_starting = false
	return state


func _ready():
	$CannonSound.volume_db = ConfigHandler.game_settings.game.sfxVol - 3.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	behave(delta)

	
		
func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	rotation += rotation_direction * spin_thrust
	set_applied_force(velocity.rotated(rotation))
	._integrate_forces(state) # parent's method


func check_collision(body):
	if body.is_in_group("asteroid"):
		current_state = _set_state(DEAD)


func _on_Area2D_body_entered(body):
	check_collision(body)


func _check_input_movement(delta):
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(engine_thrust,0)
	else:
		velocity = Vector2()
	
	if Input.is_action_pressed("ui_left"):
		rotation_direction -= 1 * delta
	if Input.is_action_pressed("ui_right"):
		rotation_direction += 1 * delta
	
	
func _check_input_shoot():
	if Input.is_action_just_pressed("ui_shoot"):
		var bullet = pre_bullet.instance()
		bullet.position = $CannonPosition.global_position
		bullet.rotation = self.rotation
		if ConfigHandler.game_settings.game.is_sfx_on == true:
			$CannonSound.play()
		get_parent().add_child(bullet)
