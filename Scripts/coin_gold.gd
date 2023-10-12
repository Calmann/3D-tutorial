extends Area3D
@onready var anim = $anim


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	anim.play("collect")
	await anim.animation_finished
	queue_free()
