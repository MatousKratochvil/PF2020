extends Light2D
class_name LightBase

var TweenNode: Tween

var light_energy

func _ready():
	var tween = Tween.new()
	add_child(tween)
	TweenNode = tween
	
	light_energy = energy
	energy = 0.0
	
func _on_visibility_changed():
	if visible:
		TweenNode.interpolate_property(self, "energy", energy, light_energy, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		TweenNode.start()