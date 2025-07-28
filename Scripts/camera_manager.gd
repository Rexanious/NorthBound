extends Node2D

@export var player = CharacterBody2D
@onready var Camera_Zone0 = $"CameraNodes/Zone0-1/PhantomCamera2D"
@onready var Camera_Zone1 = $"CameraNodes/Zone1-2/PhantomCamera2D"
@onready var Camera_Zone2 = $"CameraNodes/zone2-3/PhantomCamera2D"
@onready var Camera_Zone3 
@onready var Camera_Zone4 

var current_camera_zone: int= 0

func _ready():
	current_camera_zone = 0
	update_camera()

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
	var cameras = [Camera_Zone0, Camera_Zone1, Camera_Zone2, Camera_Zone3]
	for camera in cameras:
		if camera != null:
			camera.priority = 0
	match current_camera_zone:
		0:
			Camera_Zone0.priority = 1
		1:
			Camera_Zone1.priority = 1
		2:
			Camera_Zone2.priority = 1
	print("Camera Zone: ", current_camera_zone)

func _on_zone_01_body_entered(body: Node2D) -> void:
	update_current_zone(body, 0, 1)


func _on_zone_12_body_entered(body: Node2D) -> void:
	update_current_zone(body, 1, 2) # Replace with function body.
