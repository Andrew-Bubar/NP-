tool
extends Area2D

export var next_scene: PackedScene
onready var anim_player: AnimationPlayer = $AnimationPlayer

func teleport() -> void:
	anim_player.play("fade_in_p")
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(next_scene)

func _get_configuration_warning() -> String:
	return "the next scene property can't be empty" if not next_scene else ""

func _on_portal_body_entered(body):
	teleport()
