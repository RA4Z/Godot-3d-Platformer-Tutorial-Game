extends Node3D

@export var width: float = 5.0
@export var height: float = 5.0
@export var depth: float = 1.0

func _ready() -> void:
	self.scale = Vector3(width, height, depth)
