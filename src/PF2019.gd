extends Node

func _on_Button_pressed():
	get_tree().quit()

func _ready():
	set_process_input(true)
	set_process(true)
	for light in $StreetLights.get_children():
		light.hide()

	for light in $FloodLights.get_children():
		light.hide()
	
	
func _process(delta):
	$PF.lifetime = max(1, $PF.lifetime - delta)
	if $PF.lifetime < 7:
		$PF.position.y = min(0, $PF.position.y + 100 * delta)
	
func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
        get_tree().quit()

func _on_Background_night_occured():
	for light in $StreetLights.get_children():
		light.show()

	for light in $FloodLights.get_children():
		light.show()