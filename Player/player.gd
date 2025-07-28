extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var forwardanim = $Forwardtrack
@onready var backwardanim = $Backwardtrack
@onready var Metal = get_tree().get_nodes_in_group("Metal")
@export var magnet_pull_force := 800.0
@export var magnet_jump_force := 600.0
@export var magnet_range := 100000.0
@onready var crash_sound = $"../CrashSound"
var already_played_sound := false

@export var dust_particles: GPUParticles2D
@export var camera: PhantomCamera2D  

# Camera shake parameters
@export var shake_strength: float = 10.0
@export var shake_duration: float = 0.3

var nearest_metal = null

func _physics_process(delta):
	# Find nearest metal object
		# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
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
	
	if get_slide_collision_count() == 0:
		already_played_sound = false
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("Metal"):
			if !already_played_sound:
				crash_sound.play()
				  # Spawn dust at collision point
				dust_particles.global_position = collision.get_position()
				dust_particles.emitting = true
 # Camera shake
				camera.shake(shake_strength, shake_duration)
				already_played_sound = true
				
			velocity = Vector2.ZERO
			break
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
