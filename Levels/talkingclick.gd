extends Area2D
@onready var body = $"../../Player"
var player_in_range = false
@onready var label = $"../Control help"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body) -> void:
	label.visible = true

func _on_body_exited(body: Node2D) -> void:
	label.visible = false
