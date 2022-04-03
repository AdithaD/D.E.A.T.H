extends Control

var player
var lifecycle

func _ready():
	player = get_parent()
	$VoiceLine.visible = false
	
func _process(_delta):
	if($VoiceLine.visible && $VoiceLineTimer.is_stopped()):
		$VoiceLine.visible = false
	
func update_status_text():
	$DisplayText.text = "HP: " + String(player.health)+ ", AP: " + String(player.action_points)

func display_voice_line(voice_line):
	$VoiceLine.text = voice_line
	$VoiceLine.visible = true
	$VoiceLineTimer.start()
	
func display_ability_voice_line():
	if lifecycle.active_ability.voice_lines.size() > 0:
		var index = randi() % lifecycle.active_ability.voice_lines.size()
		var voice_line = lifecycle.active_ability.voice_lines[index]
		
		display_voice_line(voice_line)


func bind_lifecycle(new_lifecycle):
	lifecycle = new_lifecycle
	
	lifecycle.connect("doing", self, "display_ability_voice_line")

func _on_PlayerUnit_update_attr():
	update_status_text()
	pass # Replace with function body.


func _on_Gunner_update_attr():
	pass # Replace with function body.
