extends GridContainer
class_name TrackGrid

const track: PackedScene = preload("res://track.tscn")
var audio_tracks: Dictionary
signal add_track

func _ready() -> void:
	if Master.cfg.has_val("audio_tracks"): audio_tracks = Master.cfg.get_val("audio_tracks")
	if audio_tracks != {}:
		for child_name in audio_tracks:
			var child = track.instantiate()
			child.text = child_name
			child.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			self.add_child(child)
	if self.get_child_count() > 0:
		for child in self.get_children():
			self.move_child(child, audio_tracks[child.text])
	Master.saving.connect(on_saving)

func _on_add_track() -> void:
	var child = track.instantiate()
	child.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	self.add_child(child)

func on_saving():
	audio_tracks = {}
	var i: int = 0
	for child in self.get_children():
		audio_tracks[child.text] = i
		i += 1
	
	Master.cfg.set_val("audio_tracks", audio_tracks)
