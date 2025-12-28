extends RigidBody3D

const BROKEN_CRATE = preload("uid://bwqe0v5e70e6h")
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

func destroy_crate():
	var broken_crate_instance := BROKEN_CRATE.instantiate()
	add_sibling(broken_crate_instance)
	broken_crate_instance.global_position = global_position
	
	visible = false
	collision_shape_3d.set_deferred("disabled", true)
	await get_tree().create_timer(1.5).timeout
	queue_free()
