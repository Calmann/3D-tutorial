extends Node3D

func _process(delta: float) -> void:
	$CameraHub.rotate_y(0.015 * delta * 100)
