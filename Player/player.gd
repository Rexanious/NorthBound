extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var forwardanim = $Forwardtrack
@onready var backwardanim = $Backwardtrack
@onready var Metal = get_tree().get_nodes_in_group("Metal")
@export var magnet_pull_force := 800.0
@export var magnet_jump_force := 600.0
@export var magnet_range := 100000.0

var nearest_metal = null

func _physics_process(delta):
	# Find nearest metal object
		# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	track_animation()
	find_nearest_metal()
	
	# Magnet pull when X is pressed (keyboard X or gamepad X)
	if Input.is_action_pressed("Negative_pull"):
		pull_toward_metal()
	
	move_and_slide()

func find_nearest_metal():
	nearest_metal = null
	var min_distance = magnet_range
	
	var metals = get_tree().get_nodes_in_group("Metal")
	
	for metal in metals:
		var distance = global_position.distance_to(metal.global_position)
		if distance < min_distance:
			min_distance = distance
			nearest_metal = metal

func pull_toward_metal():
	if nearest_metal:
		var direction = (nearest_metal.global_position - global_position).normalized()
		velocity = direction * magnet_pull_force

func track_animation():
	if abs(velocity.x) > 0.0:
		forwardanim.play()
		backwardanim.play()
	else:
		forwardanim.stop()
		backwardanim.stop()
