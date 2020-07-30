extends Area2D

onready var anim_p: AnimationPlayer = get_node("AnimationPlayer")



func _on_Coin_body_entered(body) -> void:
	anim_p.play("fade")
