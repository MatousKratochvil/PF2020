extends Firework_Base

var init_rotation
var particle_lifetime = 0.25

func _ready():
	init_rotation = randi() / 360
	set_process(true)
	
	if $Explosion.stream is AudioStreamOGGVorbis:
		$Explosion.stream.loop = false
	$Explosion.play()
	
	if $Burning.stream is AudioStreamOGGVorbis:
		$Burning.stream.loop = false
	$Burning.play()
	
	particles = $Tails.get_children()
	sprites = $Heads.get_children()
	
	assert(particles.size() == sprites.size())
	
	var color = colors[randi() % colors.size()]
	for i in range(0, sprites.size()):
		particles[i].lifetime = particle_lifetime
		particles[i].position = position
		sprites[i].position = position
	
		particles[i].modulate = color
		sprites[i].modulate = color
	
	queue_clear()
	
func _process(delta):
	for i in range(0, sprites.size()):
		var angle = (360 / sprites.size()) * i + init_rotation
		
		if hide_head:
			sprites[i].scale.x = max(0, sprites[i].scale.x - delta * 3)
			sprites[i].scale.y = max(0, sprites[i].scale.y - delta * 3)
		else:
			sprites[i].position += Vector2(sin(deg2rad(angle)), cos(deg2rad(angle))) * delta * (speed / 2)
			sprites[i].position.y += 10 * delta
		
		particles[i].position = sprites[i].position
	
func queue_clear():
	yield(get_tree().create_timer(firework_lifetime), "timeout")
	
	for particle in particles:
		particle.emitting = false
	
	hide_head = true
	
	yield(get_tree().create_timer(firework_lifetime * 2), "timeout")
	queue_free()