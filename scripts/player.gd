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

# Mobile touch variables
var touch_start_x = 0.0
var touch_threshold = 50.0
var is_touch_device = false
var tap_zones = {"jump": Rect2(0, 0, 1080, 540), "slide": Rect2(0, 540, 1080, 540)}

func _ready():
	is_touch_device = OS.get_name() in ["Android", "iOS"]

# Update tap zones based on viewport size
func _on_viewport_size_changed():
	var vp_size = get_viewport().get_visible_rect().size
	tap_zones["jump"] = Rect2(0, 0, vp_size.x, vp_size.y / 2)
	tap_zones["slide"] = Rect2(0, vp_size.y / 2, vp_size.x, vp_size.y / 2)

func _input(event):
	if not is_alive:
		return
	
	# Mobile touch input
	if event is InputEventScreenTouch and is_touch_device:
		if event.pressed:
			touch_start_x = event.position.x
			
			# Check tap zones
			if tap_zones["jump"].has_point(event.position) and is_on_floor():
				velocity.y = jump_force
			elif tap_zones["slide"].has_point(event.position) and is_on_floor():
				is_sliding = true
				slide_timer = slide_duration
			else:
				# Swipe detection
				get_input_event()
		
		if event.pressed == false:
			# Detect swipe
			var swipe_distance = event.position.x - touch_start_x
			if swipe_distance > touch_threshold:
				current_lane = min(current_lane + 1, 1)
			elif swipe_distance < -touch_threshold:
				current_lane = max(current_lane - 1, -1)

	# Desktop keyboard input (fallback)
	if event is InputEventKey:
		get_input_event()

func get_input_event():
	# Lane switching (keyboard)
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

func _physics_process(delta):
	if not is_alive:
		return
	
	# Move forward automatically
	velocity.z += speed * delta
	
	# Handle gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle sliding
	if is_sliding:
		slide_timer -= delta
		if slide_timer <= 0:
			is_sliding = false
	
	# Move to target lane with smooth interpolation
	var target_x = current_lane * lane_width
	position.x = lerp(position.x, target_x, 0.15)
	
	move_and_slide()

func die():
	is_alive = false
	velocity = Vector3.ZERO

func get_hit_box():
	if is_sliding:
		return AABB(position - Vector3(0.5, 0.5, 0.5), Vector3(1, 0.8, 1))
	else:
		return AABB(position - Vector3(0.5, 1, 0.5), Vector3(1, 2, 1))
