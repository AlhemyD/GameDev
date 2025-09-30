extends Node2D

@onready var player = get_node("Player")
@onready var obstacle = get_node("Obstacle/asteroidArea")
@onready var enemy=get_node("Enemy")

func _ready() -> void:
	obstacle.damaged.connect(player.damage)
	
func _process(delta: float) -> void:	
	enemy.seek(player.global_position)
	enemy.flee(obstacle.global_position)
