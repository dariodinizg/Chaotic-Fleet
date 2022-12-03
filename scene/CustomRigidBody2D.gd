extends RigidBody2D

onready var sprite = get_node("Sprite")
onready var sprite_size = sprite.get_texture().get_size() * sprite.scale
onready var viewport = get_viewport().get_visible_rect().size

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	var trans = state.get_transform()
	if trans.origin.x > viewport.x + sprite_size.x/2:
		trans.origin.x -= viewport.x + sprite_size.x
	elif trans.origin.x < -sprite_size.x/2:
		trans.origin.x += viewport.x + sprite_size.x
	if trans.origin.y > viewport.y + sprite_size.y/2:
		trans.origin.y -= viewport.y + sprite_size.y
	elif trans.origin.y < -sprite_size.y/2:
		trans.origin.y += viewport.y + sprite_size.y
	state.set_transform(trans)
