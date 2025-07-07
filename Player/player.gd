extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var forwardanim = $Forwardtrack
@onready var backwardanim = $Backwardtrack


func _physics_process(delta: float) -> void:
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
	
	move_and_slide()

func track_animation():
	if abs(velocity.x) > 0.0:
		forwardanim.play()
		backwardanim.play()
	else:
		forwardanim.stop()
		backwardanim.stop()
