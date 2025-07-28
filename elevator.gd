extends CanvasLayer

@export var next_scene: PackedScene
@export var transition_time: float = 2.0
@onready var anim_player = $AnimationPlayer
@onready var texture_rect = $TextureRect

func start_elevator_ascend(player: Node2D):
	
	
	anim_player.play("ascend")  
	await anim_player.animation_finished  
	get_tree().change_scene_to_packed(next_scene)  
func _ready():
	$ColorRect.color.a = 0  # Start transparent
