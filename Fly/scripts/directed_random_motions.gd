extends Sprite2D

var random = RandomNumberGenerator.new()
@onready var window = get_parent().get_window()
@onready var size = texture.get_size()

var velocity:Vector2=Vector2(10,15)

func _ready() -> void:
	var x = random.randi_range(0+size.x, window.size.x-size.x)
	var y = random.randi_range(0+size.y, window.size.y-size.y)
	position.x=x
	position.y=y
	
	velocity.x=random.randi_range(10,100)
	velocity.y=random.randi_range(10,100)
	
func _process(delta:float)->void:
	var value=random.randf()
	if value < 0.55:
		position.x += velocity.x*delta
	elif value <0.70:
		position.x-=velocity.x*delta
	elif value <0.85:
		position.y+=velocity.y*delta
	else:
		position.y-=velocity.y*delta
	
	position.x += velocity.x*delta * random.randi_range(-1,1)
	position.y += velocity.y*delta * random.randi_range(-1,1)
