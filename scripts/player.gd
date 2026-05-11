extends CharacterBody3D

var speed = 20.0
var jump_force = 15.0
var gravity = 9.8
var slide_duration = 0.5
var is_sliding = false
var slide_timer = 0.0
var current_lane = 0  # -1 (left), 0 (middle), 1 (right)
var lane_width = 3.0
var is_alive = true

func _physics_process(delta):
	if not is_alive:
		return
	
	# Move forward automatically
	velocity.z += speed * delta
	
	# Handle gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Lane switching
	if Input.is_action_just_pressed("ui_left"):
		current_lane = max(current_lane - 1, -1)
	
	if Input.is_action_just_pressed("ui_right"):
		current_lane = min(current_lane + 1, 1)
	
	# Jumping
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force
	
	# Sliding
	if Input.is_action_just_pressed("ui_down") and is_on_floor():
		is_sliding = true
		slide_timer = slide_duration
	
	if is_sliding:
		slide_timer -= delta
		if slide_timer <= 0:
			is_sliding = false
	
	# Move to target lane
	var target_x = current_lane * lane_width
	position.x = lerp(position.x, target_x, 0.2)
	
	move_and_slide()

func die():
	is_alive = false
	velocity = Vector3.ZERO

func get_hit_box():
	if is_sliding:
		return AABB(position - Vector3(0.5, 0.5, 0.5), Vector3(1, 0.8, 1))
	else:
		return AABB(position - Vector3(0.5, 1, 0.5), Vector3(1, 2, 1))
