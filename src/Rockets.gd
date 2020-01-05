extends Node

export (PackedScene) var Rocket

export (PackedScene) var Firework_1
export (PackedScene) var Firework_2
export (PackedScene) var Firework_3

var fireworks = []

func _ready():
	fireworks.append(Firework_1)
	fireworks.append(Firework_2)
	fireworks.append(Firework_3)

func _on_Background_night_occured():
	for	i in range(0, 100):
		var rocket = Rocket.instance()
		yield(get_tree().create_timer(randf() + 0.1), "timeout")
		rocket.connect("explode", self, "create_firework")
		add_child(rocket)
		
func create_firework(position: Vector2):
	var firework = fireworks[randi() % fireworks.size()].instance()
	firework.position = position
	add_child(firework)
