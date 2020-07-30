extends Enties

export var stomp_imp: = 1000.0
export var stop_fric = 0.6
export var run_fric = 0.9

func _on_Squisher_area_entered(area: Area2D) -> void:
	
	_veloc = cal_stomp(_veloc, stomp_imp)
	
func _on_Squisher_body_entered(body: PhysicsBody2D) -> void:
	queue_free()

	
func fric() -> void:
	var run: = Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right")
	
	if not run and is_on_floor():
		_veloc.x *= stop_fric
	else:
		_veloc.x *= run_fric

func _physics_process(delta: float) -> void:
	
	var is_jump_interupted: = Input.is_action_just_released("jump") and _veloc.y < 0.0
	
	fric()
	
	_veloc = cal_velocity(_veloc, get_dir(), speed, is_jump_interupted)
	_veloc = move_and_slide(_veloc, FLOOR)
	
func get_dir() -> Vector2:
	
	return Vector2(
	Input.get_action_strength("move_right") - 
		Input.get_action_strength("move_left"),
	- 1.0 if Input.get_action_strength("jump") and is_on_floor() else 1.0
	)
	
func cal_velocity(
		liout: Vector2,
		direction: Vector2,
		speed: Vector2,
		jump_int: bool
	) -> Vector2:
		
	var out: = liout
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	
	if direction.y == -1.0:
		out.y = speed.y * direction.y
		
	if jump_int:
		out.y = 0.0
	
	return out

func cal_stomp(v: Vector2, imp: float) -> Vector2:
	
	var out: = v
	out.y = -imp
	return out
