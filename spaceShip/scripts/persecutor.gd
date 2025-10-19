extends Node2D

var acceleration: Vector2 = Vector2(0,0)
var velocity: Vector2 = Vector2(100,100)
var max_force: float = 700
@export var max_speed: float = 800
var max_distance: float = 300
@onready var window = get_parent().get_window()

var feeler_length: float = 10
@onready var line = get_node("ShipArea/Line2D")

func apply_force(force: Vector2):
	acceleration = force
	
func seek(target: Vector2):
	var direction = target - global_position
	if direction.length()>max_distance:
		return
	var desired_velocity = direction.normalized()*max_speed
	var m = remap(direction.length(), 0 , max_distance, 0, 1)
	var steering = (desired_velocity-velocity)*m
	steering = steering.limit_length(max_force)
	apply_force(steering)

func flee(target: Vector2):
	var direction = global_position - target
	if direction.length() > max_distance:
		return
	var desired_velocity = direction.normalized()*max_speed
	var steering = (desired_velocity-velocity)
	steering = steering.limit_length(max_force)
	apply_force(steering)

func pursue(target: Vector2, target_velocity: Vector2):
	var direction = target - global_position
	var speed: float = velocity.length()
	if speed == 0:
		speed = max_speed
	var ahead_time: float = direction.length()/speed
	var predict = target+target_velocity*ahead_time*10
	seek(predict)

func evade(target: Vector2, target_velocity: Vector2):
	var direction = target - global_position
	var speed: float = velocity.length()
	if speed == 0:
		speed = max_speed
	var ahead_time: float = direction.length()/speed
	var predict = target+target_velocity*ahead_time*10
	flee(predict)

#Версия без оптимизации, передаём вообще все объекты, которые нужно избегать
func separation(others: Array[Vector2]):
	var steering: Vector2 = Vector2.ZERO
	var count: int = 0
	for other in others:
		if other == global_position:
			continue
		var direction: Vector2 = other - global_position
		var distance: float = direction.length()
		if distance>=0 and distance < max_distance:
			var away: Vector2 = -direction.normalized()
			away*=1-distance/max_distance
			steering += away
			count+=1
	if count>0:
		steering/=count
		steering = steering.normalized()*max_speed
		steering -= velocity
		steering=steering.limit_length(max_force)
		apply_force(steering)
				
func alignment(others: Array[Vector2], velocities: Array[Vector2]):
	var mean_velocity:Vector2 = Vector2.ZERO
	var count:int = 0
	for i in others.size()-1:
		var other = others[i]
		var other_velocity = velocities[i]
		if other == global_position:
			continue
		var direction: Vector2 = other - global_position
		var distance: float = direction.length()
		if distance>=0 and distance<max_distance:
			mean_velocity += other_velocity
			count+=1
	if count>0:
		mean_velocity/=count
		mean_velocity=mean_velocity.normalized()*max_speed
		mean_velocity-=velocity
		var steering = mean_velocity - velocity
		apply_force(steering.limit_length(max_force))

func cohesion(others: Array[Vector2]):
	#По идее надо так:
	var center_of_mass:Vector2 = Vector2.ZERO
	var count:int = 0
	
	#Вычисляем центр масс
	for other in others:
		if other==global_position:
			continue
		var direction: Vector2 = other - global_position
		var distance: float = direction.length()
		if distance>=0 and distance<max_distance:
			center_of_mass+=other
			count+=1
	if count>0:
		center_of_mass/=count
	seek(center_of_mass)
	
#	Но я сделал так: (То же, что и separation, но away другой)
	#var steering:Vector2 = Vector2.ZERO
	#var count: int = 0 
	#for other in others:
		#if other==global_position:
			#continue
		#var direction: Vector2 = other - global_position
		#var distance: float = direction.length()
		#if distance>=0 and distance < max_distance:
			#var away: Vector2 = direction.normalized()
			#away*=1-distance/max_distance
			#steering += away
			#count+=1
	#if count>0:
		#steering/=count
		#steering = steering.normalized()*max_speed
		#steering -= velocity
		#steering=steering.limit_length(max_force)
		#apply_force(steering)

func avoidance(target:Vector2):
	var forward: Vector2  = velocity.normalized()
	var center_feeler = global_position+forward*feeler_length
	line.points[0]=global_position
	line.points[1]=center_feeler
	
func update(delta: float):
	velocity+=acceleration*delta
	velocity = velocity.limit_length(max_speed)
	global_position+=velocity*delta
	acceleration *= 0	
	rotation = velocity.angle()-PI/2

func _process(delta: float) -> void:
	update(delta)
	if global_position.x > window.size.x:
		global_position.x = 0
	elif global_position.y>window.size.y:
		global_position.y = 0
	elif global_position.x < 0 :
		global_position.x = window.size.x
	elif global_position.y<0:
		global_position.y = window.size.y
	

	
	
	
	
	
