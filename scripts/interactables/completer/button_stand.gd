extends Completer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var soundeffect_3d: SoundEffect3D = $SoundEffect3D

func _on_interaction_area_interacted():
	if completed:
		animation_player.play_backwards("press")
		soundeffect_3d.play_key("down")
	else:
		animation_player.play("press")
		soundeffect_3d.play_key("up")
	toggle_complete()
	if one_shot:
		await animation_player.animation_finished
		$Button.hide()
