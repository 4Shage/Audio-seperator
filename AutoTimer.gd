extends Timer
class_name AutoTimer

func _enter_tree() -> void:
	self.autostart = true
	self.start(self.wait_time)
