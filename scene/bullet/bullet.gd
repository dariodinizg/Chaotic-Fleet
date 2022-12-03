extends "res://scene/CustomRigidBody2D.gd"

export(float) var cannon_power = 300
export(float) var bullet_energy = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_max_contacts_reported(1)
	$Timer.wait_time = bullet_energy
	$Timer.start()
	self.linear_velocity = Vector2(cannon_power,0).rotated(rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Timer.time_left == 0:
		queue_free()
		sleeping = true

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	var contacts = state.get_contact_count()
	for i in range(contacts):
		var contact = state.get_contact_collider_object(i)
		if contact.is_in_group("asteroid"):
			contact._explode()
#			contact.emit_signal("explode")
			queue_free()
#			sleeping = true
	._integrate_forces(state)
