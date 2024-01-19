extends Completer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_interaction_area_interacted():
	animation_player.play("press")
	super.toggle_complete()
