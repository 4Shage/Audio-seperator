extends ConfigFile
class_name AppConfig

@export var SECTION: String

func get_val(key: String, default: Variant = null) -> Variant:
	return self.get_value(SECTION,key,default)

func set_val(key: String, default: Variant = null) -> void:
	self.set_value(SECTION,key,default)

func has_val(key: String) -> bool:
	return self.has_section_key(SECTION,key)
