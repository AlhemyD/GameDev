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
	
	velocity.x=random.randi_range(-100,100)
	velocity.y=random.randi_range(-100,100)
	
func _process(delta):
	position.x += velocity.x*delta
	position.y += velocity.y*delta
