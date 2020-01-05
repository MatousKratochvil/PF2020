extends Node2D
class_name Rocket

const speed = 300.0
var explode_height = 0.0

signal explode

func _ready():
	set_process(true)
	var size = get_viewport_rect().size
	position.x = (size.x - size.x / 10) * randf() + (size.x / 10) / 2
	position.y = size.y
	
	explode_height = (size.y / 10) * randf() + size.y / 10
	
func _process(delta):
	position.y -= speed * delta
		
	if position.y < explode_height:
		emit_signal("explode", position)
		queue_free()