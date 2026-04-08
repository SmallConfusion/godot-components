class_name CompileInfoLabel
extends Label

func _ready() -> void:
	text = "Build:\n%s\n%s" % [BuildInfo.BUILD_TIME, BuildInfo.GIT_COMMIT]
