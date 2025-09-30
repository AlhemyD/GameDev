extends Node2D

##Money
#@export var coins := 10
#var healths
#var path = "Sprite2D"

##Setup the initial force
#@export_range(0, 1.0, 0.1, "Base force") var forcee: float=0.5


@export var nflies: int = 10

@onready var fly_scene = preload("res://scenes/fly.tscn")
@onready var bee_scene = preload("res://scenes/bee.tscn")

var scripts=[preload("res://scripts/directed_random_motions.gd"),
preload("res://scripts/perlin_motion.gd"),
preload("res://scripts/simple_motion.gd"),
preload("res://scripts/random_motion.gd")]

var random = RandomNumberGenerator.new()

func _ready():
	#simple comment
	# CRITICAL: fix my code
	# BUG: it's a bug
	# INFO: something
	#print(type_string(typeof(path)))
	
	#region Some calculation
	
	#var a = 2
	#var b = 3
	#var z = a+b
	
	#endregion
	
	for i in nflies:
		print("create flies %d" % i)
		var instance
		var value = random.randf()
		if value<0.7:
			instance = fly_scene.instantiate()
		else:
			instance=bee_scene.instantiate()
		
		instance.get_child(0).set_script(scripts[random.randi_range(0,3)])
		
		add_child(instance)
		
	
	
