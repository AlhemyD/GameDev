extends Node2D

var speed: float = 0
var max_speed: float = 500
var velocity: Vector2 = Vector2(0, 0)

@onready var shield:Sprite2D = get_node("ShipArea/ShipSprite/ShieldSprite")
@onready var shipFire:AnimatedSprite2D = get_node("ShipArea/ShipSprite/ShipFire")

func player():
	pass

func animation_process():
	if speed <= 0:
		shipFire.visible=false
	else:
		shipFire.visible=true
	if speed>0 and speed <125:
		shipFire.frame=0
	elif speed >= 250 and speed < 400:
		shipFire.frame=1
	elif speed >=400:
		shipFire.frame=2

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		rotation -= 0.1
	if Input.is_action_pressed("ui_right"):
		rotation += 0.1
	if Input.is_action_pressed("ui_up"):
		speed += 5
		if speed > max_speed:
			speed = max_speed
	if Input.is_action_pressed("ui_down"):
		speed -= 5
		if speed < 0:
			speed = 0
	var x = 0.1 * cos(rotation+PI/2)
	var y = 0.1 * sin(rotation + PI/2)
	velocity = speed * delta * Vector2(x,y).normalized()
	position += velocity
	animation_process()
	
	
func damage():	
	if shield.visible:
		shield.visible = false
	else:
		pass
