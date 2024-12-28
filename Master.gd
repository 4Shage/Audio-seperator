extends Node

var cfg: AppConfig = AppConfig.new()
const cfg_path: String = "user://sett.cfg"

var at: AutoTimer = AutoTimer.new()
var command

signal saving

func _ready() -> void:
	if FileAccess.file_exists(cfg_path):
		cfg.load(cfg_path)
	cfg.SECTION = "AudioSeparetor"
	at.wait_time = 5
	at.timeout.connect(savingCFG)
	add_child(at)
	


func savingCFG():
	saving.emit()
	await get_tree().create_timer(2).timeout
	cfg.save(cfg_path)

var th: Thread = Thread.new()

func _on_pressed() -> void:
	if !cfg.has_val("file_path"):
		print("No file selected")
		return
	else: print(cfg.get_val("file_path"))
	command = "cd "+"\'"+(cfg.get_val("file_path").replace(cfg.get_val("file_name"),""))+"\'"+";"+"ffmpeg -i " + "'./"+cfg.get_val("file_name")+"'"
	if cfg.has_val("audio_tracks"):
		for e: String in cfg.get_val("audio_tracks"):
			command = command + " " + "-map 0:a:" + str(cfg.get_val("audio_tracks")[e]) + " "+(cfg.get_val("file_name").replace(cfg.get_val("file_name").get_extension(), "")).replace(" ", "-") + "-" + e + ".aac"
	else:
		print("Zero tracks")
		return
	print("start")
	th.start(seperate_tracks,Thread.PRIORITY_HIGH)

func _process(_delta: float) -> void:
	if th.is_started():
		if !th.is_alive():
			print(str(th.wait_to_finish()))
			

func seperate_tracks() -> Array:
	var output: Array
	# Execute the command in PowerShell
	print(command)
	var result = OS.execute("powershell.exe", ["-Command",command], output,true, true)
	
	if result == OK:
		print("Command executed successfully.")
	else:
		print("Failed to execute command.")
	return output
