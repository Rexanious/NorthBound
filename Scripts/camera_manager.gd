extends Node2D

@export var player = CharacterBody2D
@export var camera_zone0 = PhantomCamera2D
@export var camera_zone1 = PhantomCamera2D
@export var camera_zone2 = PhantomCamera2D
@export var camera_zone3 = PhantomCamera2D
@export var camera_zone4 = PhantomCamera2D
@export var camera_zone5 = PhantomCamera2D
var current_camera_zone: int= 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_current_zone(body, zone_a, zone_b):
	if body == player:
		match current_camera_zone:
			zone_a:
				current_camera_zone = zone_b
			zone_b:
				current_camera_zone = zone_a
		update_camera()

func update_camera():
	print("Camera Zone: ", current_camera_zone)

func _on_zone_01_body_entered(body: Node2D) -> void:
	update_current_zone(body, 0, 1)
