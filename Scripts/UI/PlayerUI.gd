extends Control

var player
var lifecycle

export (NodePath) var health_display
export (NodePath) var action_point_display

func _ready():
	player = get_parent()
	$VoiceLine.visible = false
	
func _process(_delta):
	if($VoiceLine.visible && $VoiceLineTimer.is_stopped()):
		$VoiceLine.visible = false
	
#func update_status_text():
#	$DisplayText.text = "HP: " + String(player.health)+ ", AP: " + String(player.action_points)

func display_voice_line(voice_line):
	$VoiceLine.text = voice_line
	$VoiceLine.visible = true
	$VoiceLineTimer.start()
	$AnimationPlayer.play("text float off")
	
func display_ability_voice_line():
	if lifecycle.active_ability.voice_lines.size() > 0:
		var index = randi() % lifecycle.active_ability.voice_lines.size()
		var voice_line = lifecycle.active_ability.voice_lines[index]
		
		display_voice_line(voice_line)

func on_death():
	get_node(health_display).visible = false
	get_node(action_point_display).visible = false
		
func bind_lifecycle(new_lifecycle):
	lifecycle = new_lifecycle
	
	lifecycle.connect("doing", self, "display_ability_voice_line")

func _on_Unit_update_attr():
	$MarkedIcon.visible = player.is_marked
