extends Node2D

signal night_occured

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("night_occured")
