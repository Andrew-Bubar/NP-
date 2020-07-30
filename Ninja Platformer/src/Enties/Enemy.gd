extends Enties

func _ready():
	#set_physics_process(false)
	_veloc.x = -speed.x
	

func _physics_process(delta: float) -> void:
	_veloc.y += gravity * delta
	
	if is_on_wall():
		_veloc.x *= -1.0
		
	_veloc.y = move_and_slide(_veloc, FLOOR).y


func _on_stomped_body_entered(body: PhysicsBody2D) -> void:
	
	if body.global_position.y < get_node("stomped").global_position.y:
	
		get_node("CollisionShape2D").disabled = true
	
		queue_free() #die 

