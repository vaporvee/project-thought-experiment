extends Completer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_interaction_area_interacted():
	animation_player.play("press")
	toggle_complete()
	if one_shot:
		await animation_player.animation_finished
		$Button.hide()
