extends Sprite2D

var random = RandomNumberGenerator.new()
@onready var window = get_parent().get_window()
@onready var size = texture.get_size()

var time: float=0
var noise: FastNoiseLite

func _ready() -> void:
	var x = random.randi_range(0+size.x, window.size.x-size.x)
	var y = random.randi_range(0+size.y, window.size.y-size.y)
	position.x=x
	position.y=y
	
	noise = FastNoiseLite.new()
	noise.noise_type=FastNoiseLite.TYPE_PERLIN
	noise.fractal_octaves = 3
	noise.fractal_lacunarity=2.0
	noise.fractal_gain=0.5
	noise.frequency = random.randf()+0.1
	noise.seed=random.randi_range(0,1000
	)
	
	
func _process(delta):
	var nx = noise.get_noise_2d(time*0.02, 0)
	var ny= noise.get_noise_2d(time*0.02, 100)
	
	position.x=remap(nx, -0.5, 0.5,0, window.size.x)
	position.y=remap(ny, -0.5,0.5,0, window.size.y)
	time+=delta*20
	
