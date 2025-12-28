extends CharacterBody3D

const SPEED := 100.0
const CHASE_RANGE := 4.0
const ATTACK_RANGE := 1.0
const SMOKE := preload("uid://okmv1cbta83x")

@export var target : CharacterBody3D
@onready var nav_agent: NavigationAgent3D = $nav_agent
@onready var animation_tree: AnimationTree = $beetle_bot_skin/AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var collision_body: CollisionShape3D = $collision_body

var is_dead := false

func _process(delta: float) -> void:
	if is_dead:
		return
		
	velocity = Vector3.ZERO
	match state_machine.get_current_node():
		"idle":
			look_at(Vector3(target.global_position.x, global_position.y, target.global_position.z), Vector3.UP)
		"walk":
			if global_position.distance_to(target.global_position) < CHASE_RANGE:
				nav_agent.set_target_position(target.global_transform.origin)
				var next_nav_point = nav_agent.get_next_path_position()
				velocity = (next_nav_point - global_transform.origin).normalized() * SPEED * delta
				look_at(Vector3(target.global_position.x, global_position.y, target.global_position.z), Vector3.UP)
		"attack":
			look_at(Vector3(target.global_position.x, global_position.y, target.global_position.z), Vector3.UP)
	
	animation_tree.set("parameters/conditions/walk", chase_player())
	animation_tree.set("parameters/conditions/idle", not chase_player())
	animation_tree.set("parameters/conditions/attack", attack_player())
	
	move_and_slide()

func chase_player():
	return global_position.distance_to(target.global_position) < CHASE_RANGE

func attack_player():
	return global_position.distance_to(target.global_position) < ATTACK_RANGE


func _on_hurtbox_body_entered(body: Node3D) -> void:
	if body.name == "player":
		body.gravity = -body.JUMP_VELOCITY
		is_dead = true
		collision_body.set_deferred("disabled", true)
		state_machine.travel("poweroff")
		
		await animation_tree.animation_finished
		var puff_effect = SMOKE.instantiate()
		get_parent().add_child(puff_effect)
		puff_effect.global_position = global_position
		await puff_effect.full
		queue_free()
