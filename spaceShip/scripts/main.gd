extends Node2D

@onready var player = get_node("Player")
@onready var obstacle = get_node("Obstacle/asteroidArea")
@onready var enemy=get_node("Enemy")
@onready var enemy_seek=get_node("Enemy_seek")



func _ready() -> void:
	obstacle.damaged.connect(player.damage)
	
func _process(delta: float) -> void:	
	#enemy.seek(player.global_position)
	#enemy.flee(obstacle.global_position)
	#enemy.evade(obstacle.global_position, obstacle.velocity)
	#enemy_seek.flee(obstacle.global_position)
	var targets: Array[Vector2]
	var velocities:Array[Vector2]
	targets.append(enemy.global_position)
	targets.append(enemy_seek.global_position)
	#targets.append(player.global_position)
	#targets.append(obstacle.global_position)
	#velocities.append(enemy.velocity)
	#velocities.append(enemy_seek.velocity)
	#velocities.append(player.velocity)
	#velocities.append(obstacle.velocity)
	enemy.avoidance(enemy.global_position)
	enemy_seek.avoidance(enemy_seek.global_position)
	
