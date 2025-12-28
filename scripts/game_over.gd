extends CanvasLayer

func _on_retry_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

func _on_visibility_changed() -> void:
	if self.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
