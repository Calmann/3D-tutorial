extends CharacterBody3D


var enemyHP := 3
var damage := 1
var attackDistance := 1.0
var attackRate := 1.0
var enemySpeed := 2.5
@onready var timer := $attackTimer
@onready var player := get_node("/root/World/Character")

const UP = Vector3.UP

func _ready() -> void:
	timer.wait_time = attackRate
	timer.start()
	
func _physics_process(delta: float) -> void:
	var distance = position.distance_to(player.position)
	if distance > attackDistance:
		var direction = (player.position - position).normalized()
		velocity = Vector3(direction.x, 0, direction.z)
		move_and_slide()

func takeDamage(damage):
	enemyHP -= damage
	if enemyHP <= 0:
		queue_free()


func _on_attack_timer_timeout() -> void:
	if position.distance_to(player.position) <= attackDistance:
		player.takeDamage(damage)
